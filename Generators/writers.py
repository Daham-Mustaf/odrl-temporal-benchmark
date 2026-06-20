"""
writers.py  (Temporal Decomposition generator)
==============================================
Writes .p (FOF/TPTP), .smt2 (SMT-LIB), and .ttl (Turtle) files for the
ODRL Temporal Decomposition benchmark.

Conventions:
- If fof_conjecture is None or empty, NO conjecture line is emitted; the
  prover refutes the axiom set (Unsatisfiable / conflict problems) or
  model-builds it (Satisfiable / compatible problems).
- If status_smt is None or smt2_asserts is empty, NO .smt2 file is written
  (the problem is FOL-only, e.g. a meta-theorem).
"""

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from header import problem_header, SMTHeader

# Category -> the extra axiom file that category's problems include, on top of
# BASE_AXIOMS. Finalised together with the axiom phase.
CATEGORY_AXIOMS = {
    "ConflictCriterion": "PREC000-0.ax",
    "Projection":        "PROJ000-0.ax",
    "Composition":       "COMP000-0.ax",
    "LogicalOr":         "COMP000-0.ax",
    "LogicalXone":       "COMP000-0.ax",
    "Completion":        "COMPL000-0.ax",
    "Refinement":        "SUBS000-0.ax",
    "WellFormedness":    "WF000-0.ax",
    # Periodic / CrossOperand / Sequence are self-contained: they set
    # includes=[] and inline their theory ($int recurrence, Phi, STN), so
    # they take no category axiom. FRAME000-0.ax / SEQ000-0.ax remain in
    # Axioms/ as documentation of those background theories.
}

# Base axioms every problem includes unless p['includes'] overrides them.
# The denotation / verdict-algebra core (the spatial AXIS000 analogue) is
# added here once it is named in the axiom phase.
BASE_AXIOMS = ["ORD000-0.ax", "DENOT000-0.ax"]


def write_fof_problem(p: dict, out_dir: Path) -> Path:
    subdir = out_dir / p["subdir"]
    subdir.mkdir(parents=True, exist_ok=True)

    explicit = "includes" in p
    inc_list = list(p["includes"]) if explicit else list(BASE_AXIOMS)
    if p.get("needs_density") and "ORD001-0.ax" not in inc_list:
        inc_list.insert(1, "ORD001-0.ax")   # density, right after ORD000
    if not explicit:                          # category axiom is a default, not an override
        cat_axiom = CATEGORY_AXIOMS.get(p.get("subdir"))
        if cat_axiom and cat_axiom not in inc_list:
            inc_list.append(cat_axiom)
    includes = "".join(f"include('Axioms/{ax}').\n" for ax in inc_list)

    conj = p.get("fof_conjecture")
    if conj is None or (isinstance(conj, str) and conj.strip() == ""):
        conjecture_fof = ""
        conjecture_header = (
            "% (No conjecture: prover refutes/satisfies the axiom set.)\n"
        )
    else:
        conj_id = p["id"].lower()
        lang = p.get("tptp_lang", "fof")   # "tff" for arithmetic (Mod/Diff) tiers
        conjecture_fof = f"{lang}({conj_id}, conjecture,\n    {conj}).\n"
        conjecture_header = "% \u2500\u2500\u2500 Conjecture " + "\u2500" * 52 + "\n"

    content = (
        problem_header(p, "temporal")
        + includes
        + "\n"
        + "% \u2500\u2500\u2500 Named constants and ordering " + "\u2500" * 37 + "\n"
        + p["fof_extra_decls"]
        + conjecture_header
        + conjecture_fof
        + "%--------------------------------------------------------------------------\n"
    )
    path = subdir / f"{p['id']}-1.p"
    path.write_text(content, encoding="utf-8")
    return path


def write_smt2_problem(p: dict, out_dir: Path) -> Path | None:
    """Write the .smt2 file, or return None for FOL-only problems
    (status_smt is None, or smt2_asserts empty)."""
    if p.get("status_smt") is None:
        return None
    asserts = (p.get("smt2_asserts") or "").strip()
    if not asserts:
        return None

    subdir = out_dir / p["subdir"]
    subdir.mkdir(parents=True, exist_ok=True)

    logic = p.get("smt2_logic", "QF_LRA")
    decls = p.get("smt2_decls", "(declare-const x Real)")
    smt_header = SMTHeader(
        file     = f"{p['id']}-1.smt2",
        domain   = "temporal",
        title    = p["name"],
        version  = "1.0",
        refs     = ["temporal2026"],
        comments = (
            f"Verdict: {p['verdict']}  "
            f"Category: {p['subdir']}  "
            f"Difficulty: {p.get('difficulty', 'Easy')}"
        ),
        status   = p["status_smt"],
    ).render()

    content = "\n".join([
        smt_header,
        f"(set-logic {logic})",
        decls,
        asserts,
        "(check-sat)",
        "(exit)",
        "",
    ])
    path = subdir / f"{p['id']}-1.smt2"
    path.write_text(content, encoding="utf-8")
    return path


def write_ttl_policy(p: dict, policies_dir: Path) -> Path:
    policies_dir.mkdir(parents=True, exist_ok=True)
    path = policies_dir / f"{p['id']}-policy.ttl"
    path.write_text(p["ttl"].strip() + "\n", encoding="utf-8")
    return path