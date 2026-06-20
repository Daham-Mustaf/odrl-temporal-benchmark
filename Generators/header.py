"""
header.py  (Temporal Decomposition generator)
=============================================
TPTP / SMT-LIB header rendering for the ODRL temporal benchmark.

Statistics (% Syntax block) are intentionally omitted; tptp4X computes
and inserts them during TPTP library processing.
"""

import re
from dataclasses import dataclass

REFS = {
    "temporal2026": (
        "[Anonymous26d] Anonymous. "
        "Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort "
        "Ambiguity in Policy Constraints. LPAR-26 (anonymized for review)."
    ),
}

DOMAINS = {
    "temporal": "ODRL Policy / Temporal Decomposition",
}

SPC = {
    "theorem":    "FOF_THM_RFN",
    "unsat":      "FOF_UNS_RFN",
    "sat":        "FOF_SAT_RFN",
    "countersat": "FOF_CSA_RFN",
}

# ---------------------------------------------------------------------------
# Formula counting (used by _ax_comment in the axiom generator).
# Counts fof, tff, and cnf: temporal axioms span FOF (Ord tier) and typed
# first-order with arithmetic (Diff/Mod tiers).
# ---------------------------------------------------------------------------
def _count_formulae(text):
    return len(re.findall(r"^(?:fof|tff|cnf)\s*\(", text, re.MULTILINE))

def _ax_comment(body: str, breakdown: str, include_note: str) -> str:
    n = _count_formulae(body)
    return f"{include_note}\n{n} axioms: {breakdown}."

# ---------------------------------------------------------------------------
# Formatting helpers
# ---------------------------------------------------------------------------
def _wrap(label, text):
    lines = text.strip().split("\n")
    pad = " " * 11
    out = f"% {label:<9s}: {lines[0]}"
    for line in lines[1:]:
        out += f"\n%{pad}: {line.strip()}"
    return out

def _smt_wrap(label, text):
    lines = text.strip().split("\n")
    out = f"; {label:<9s}: {lines[0]}"
    for line in lines[1:]:
        out += f"\n;            {line.strip()}"
    return out

def _refs_block(keys):
    lines = []
    for i, k in enumerate(keys):
        if k not in REFS:
            raise KeyError(f"Unknown ref key '{k}'. Add it to header.REFS.")
        label = "Refs" if i == 0 else "     "
        lines.append(f"% {label}     : {REFS[k]}")
    return "\n".join(lines)

def _smt_refs_block(keys):
    lines = []
    for i, k in enumerate(keys):
        if k not in REFS:
            raise KeyError(f"Unknown ref key '{k}'. Add it to header.REFS.")
        label = "Refs" if i == 0 else "     "
        lines.append(f"; {label}     : {REFS[k]}")
    return "\n".join(lines)

_SEP     = "%--------------------------------------------------------------------------\n"
_SMT_SEP = "; --------------------------------------------------------------------------\n"

# ---------------------------------------------------------------------------
# Header dataclasses
# ---------------------------------------------------------------------------
@dataclass
class Header:
    """TPTP header for .p problem files."""
    file:     str
    domain:   str
    title:    str
    version:  str
    english:  str
    status:   str
    refs:     list
    comments: str
    spc:      str = ""
    verdict:  str = ""    # Conflict | Compatible | Unknown | CounterSatisfiable
    relation: str = ""    # conflict | subsumption | verdict_algebra

    def _infer_spc(self):
        # Ord-tier problems are FOF; Diff/Mod (typed arithmetic) problems
        # pass spc explicitly (e.g. a TFA_* code).
        if self.spc:
            return self.spc
        s = self.status.lower()
        if "theorem"       in s: return SPC["theorem"]
        if "counter"       in s: return SPC["countersat"]
        if "unsatisfiable" in s or "unsat" in s: return SPC["unsat"]
        if "satisfiable"   in s or "sat"   in s: return SPC["sat"]
        return "FOF_UNK_RFN"

    def render(self):
        return (
            _SEP
            + f"% File     : {self.file}\n"
            + f"% Domain   : {DOMAINS[self.domain]}\n"
            + f"% Problem  : {self.title}\n"
            + f"% Version  : {self.version}\n"
            + _wrap("English", self.english) + "\n"
            + "%\n"
            + _refs_block(self.refs) + "\n"
            + "% Source   : anonymous\n"
            + "% Authors  : anonymous\n"
            + f"% Names    : {self.file}\n"
            + "%\n"
            + f"% Status   : {self.status}\n"
            + (f"% Verdict  : {self.verdict}\n" if self.verdict else "")
            + (f"% Relation : {self.relation}\n" if self.relation else "")
            + f"% SPC      : {self._infer_spc()}\n"
            + "%\n"
            + _wrap("Comments", self.comments) + "\n"
            + _SEP
        )

@dataclass
class AXHeader:
    """TPTP header for .ax axiom files."""
    file:     str
    domain:   str
    title:    str
    version:  str
    english:  str
    refs:     list
    comments: str
    spc:      str = "FOF_SAT_RFN"

    def render(self):
        return (
            _SEP
            + f"% File     : {self.file}\n"
            + f"% Domain   : {DOMAINS[self.domain]}\n"
            + f"% Axioms   : {self.title}\n"
            + f"% Version  : {self.version}\n"
            + _wrap("English", self.english) + "\n"
            + "%\n"
            + _refs_block(self.refs) + "\n"
            + "% Source   : anonymous\n"
            + "% Authors  : anonymous\n"
            + f"% Names    : {self.file}\n"
            + "%\n"
            + "% Status   : Satisfiable\n"
            + f"% SPC      : {self.spc}\n"
            + "%\n"
            + _wrap("Comments", self.comments) + "\n"
            + _SEP
        )

@dataclass
class SMTHeader:
    """SMT-LIB 2 header for .smt2 files."""
    file:     str
    domain:   str
    title:    str
    version:  str
    refs:     list
    comments: str
    status:   str = "unknown"

    def render(self):
        return (
            _SMT_SEP
            + f"; File     : {self.file}\n"
            + f"; Domain   : {DOMAINS[self.domain]}\n"
            + f"; Axioms   : {self.title}\n"
            + f"; Version  : {self.version}\n"
            + f"; Authors  : anonymous\n"
            + _smt_refs_block(self.refs) + "\n"
            + "; Source   : anonymous\n"
            + f"; Names    : {self.file}\n"
            + f"; Status   : {self.status}\n"
            + _smt_wrap("Comments", self.comments) + "\n"
            + _SMT_SEP
        )

# ---------------------------------------------------------------------------
# Convenience factory used by the problem generator
# ---------------------------------------------------------------------------
def problem_header(p, domain="temporal"):
    lang = p.get("tptp_lang", "fof")
    st = p["status_fof"].lower()
    if lang == "tff":                       # typed arithmetic (Diff / Mod tiers)
        spc = ("TF0_THM" if "theorem" in st else
               "TF0_CSA" if "counter" in st else
               "TF0_UNS" if ("unsat" in st or "unsatisfiable" in st) else
               "TF0_SAT" if "sat" in st else "TF0_UNK")
    else:
        spc = ""                            # Header._infer_spc picks the FOF_* code
    return Header(
        file     = f"{p['id']}-1.p",
        domain   = domain,
        title    = p["name"],
        version  = "1.0",
        english  = p.get("description", p["name"]),
        status   = p["status_fof"],
        refs     = ["temporal2026"],
        spc      = spc,
        comments = (
            "Temporal decomposition tier. LPAR-26 (anonymized).\n"
            f"Policy source: Policies/{p['id']}-policy.ttl"
        ),
        verdict  = p.get("verdict", ""),
        relation = p.get("relation", ""),
    ).render()

# ---------------------------------------------------------------------------
# Self-test
# ---------------------------------------------------------------------------
if __name__ == "__main__":
    sample = """\
fof(c1, axiom, lt(dateTime, d2026_12_31)).
fof(c2, axiom, eq(dateTime, d2027_06_01)).
tff(bg, axiom, $lesseq(metered, elapsed)).
"""
    note = (
        "Depends on ORD000-0.ax (loaded by the problem file).\n"
        "Include for cross-operand bounds:\n"
        "  include('Axioms/ORD000-0.ax').\n"
        "  include('Axioms/DUR000-0.ax')."
    )
    c = _ax_comment(sample, "2 cmp + 1 bg", note)
    assert "3 axioms:" in c, c
    print("_ax_comment OK:", c.splitlines()[-1])

    print("\n=== Header (.p) ===")
    print(Header(
        file="ODRL800-1.p", domain="temporal",
        title="ConflictCriterion -- dateTime lt vs eq, disjoint instants",
        version="1.0",
        english="An upper-bounded dateTime and a fixed later dateTime are disjoint.",
        status="Unsatisfiable", refs=["temporal2026"],
        verdict="Conflict", relation="conflict",
        comments="Temporal decomposition tier. LPAR-26 (anonymized).\nRequires Axioms/ORD000-0.ax + Axioms/PREC000-0.ax.",
    ).render())

    print("=== AXHeader (.ax) ===")
    print(AXHeader(
        file="ORD000-0.ax", domain="temporal",
        title="Total order on the timeline and the duration domain",
        version="1.0",
        english="Order axioms for the ODRL Temporal Decomposition benchmark.",
        refs=["temporal2026"],
        comments=_ax_comment(sample, "2 cmp + 1 bg", note),
    ).render())

    print("=== SMTHeader (.smt2) ===")
    smt = SMTHeader(
        file="ODRL800-1.smt2", domain="temporal",
        title="ConflictCriterion dateTime", version="1.0",
        refs=["temporal2026"],
        comments="Verdict: Conflict. Category: ConflictCriterion.",
        status="unsat",
    ).render()
    print(smt)
    bad = [l for l in smt.splitlines() if l and not l.startswith(";")]
    assert not bad, f"BARE LINES: {bad}"
    print("All SMTHeader lines start with ';'")