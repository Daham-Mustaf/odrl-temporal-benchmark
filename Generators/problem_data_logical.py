"""
problem_data_logical.py  -- LogicalOr (ODRL843-845) + LogicalXone (ODRL846-848), Ord/FOF.
A disjunctive consumer policy vs a single-point provider offer. or(B1,..) denotes the
UNION of the branch denotations; xone the symmetric difference (exactly one branch). The
verdict reduces to satisfiability of (offer & combine(branches)): Conflict iff unsat,
Compatible iff sat (Def. or-verdict; Unknown is out of scope here). dateTime instants
i_N = 2026-01-01 + N days, ordered via ORD000 (FOF, so Vampire AND E both solve).

MATCHED DISCRIMINATOR: ODRL844 (or, offer 2026-09-01) is Compatible but ODRL846 (xone,
SAME two branches + SAME offer) is Conflict -- 2026-09-01 satisfies BOTH gteq branches,
which or includes but xone excludes.
"""
INC = ["ORD000-0.ax"]
VAL = {"apr1": 90, "jun1": 151, "jul1": 181, "aug1": 212, "sep1": 243}   # Jan 1 = day 0
ISO = {"apr1": "2026-04-01", "jun1": "2026-06-01", "jul1": "2026-07-01",
       "aug1": "2026-08-01", "sep1": "2026-09-01"}

def mem_fof(op, d):
    return {"eq": f"X = {d}", "lt": f"less(X, {d})", "gt": f"less({d}, X)",
            "lteq": f"leq(X, {d})", "gteq": f"leq({d}, X)"}[op]
def mem_smt(op, d):
    return {"eq": f"(= x {VAL[d]})", "lt": f"(< x {VAL[d]})", "gt": f"(> x {VAL[d]})",
            "lteq": f"(<= x {VAL[d]})", "gteq": f"(>= x {VAL[d]})"}[op]

def order_block(consts):
    cs = sorted(set(consts), key=lambda c: VAL[c])
    L = [f"fof(ord_{cs[i]}_{cs[i+1]}, axiom, less({cs[i]}, {cs[i+1]}))." for i in range(len(cs) - 1)]
    L.append(f"fof(distinct, axiom, $distinct({', '.join(cs)})).")
    return "\n".join(L) + "\n"

def combine_fof(kind, branches):
    m = [mem_fof(op, d) for op, d in branches]
    if kind == "or":
        return "(" + " | ".join(m) + ")"
    return f"(({m[0]} & ~({m[1]})) | (~({m[0]}) & {m[1]}))"   # xone, 2 branches
def combine_smt(kind, branches):
    m = [mem_smt(op, d) for op, d in branches]
    if kind == "or":
        return "(or " + " ".join(m) + ")"
    return f"(or (and {m[0]} (not {m[1]})) (and (not {m[0]}) {m[1]}))"

def _ttl(kind, offer, branches):
    oop, od = offer
    blist = "".join(
        f'\n        [ odrl:leftOperand odrl:dateTime ; odrl:operator odrl:{op} ; '
        f'odrl:rightOperand "{ISO[d]}T00:00:00"^^xsd:dateTime ]' for op, d in branches)
    return ("@prefix odrl: <http://www.w3.org/ns/odrl/2/> .\n"
            "@prefix xsd:  <http://www.w3.org/2001/XMLSchema#> .\n"
            "@prefix drk:  <http://w3id.org/drk/ontology/> .\n"
            "# provider offer (single point)\n"
            "drk:policyA a odrl:Set ;\n  odrl:permission [ odrl:action odrl:use ;\n"
            f'    odrl:constraint [ odrl:leftOperand odrl:dateTime ; odrl:operator odrl:{oop} ; '
            f'odrl:rightOperand "{ISO[od]}T00:00:00"^^xsd:dateTime ] ] .\n'
            f"# consumer request: {kind} of the branches\n"
            "drk:policyB a odrl:Set ;\n  odrl:permission [\n    odrl:action odrl:use ;\n"
            f"    odrl:constraint [\n      odrl:{kind} ({blist}\n      )\n    ]\n  ] .")

def _P(pid, kind, name, verdict, descr, offer, branches):
    subdir = "LogicalOr" if kind == "or" else "LogicalXone"
    consts = [offer[1]] + [d for _, d in branches]
    inner = f"{mem_fof(*offer)} & {combine_fof(kind, branches)}"
    conj = f"?[X]: ({inner})" if verdict == "Compatible" else f"![X]: ~({inner})"
    asserts = f"(assert {mem_smt(*offer)})\n(assert {combine_smt(kind, branches)})"
    return {
        "id": pid, "subdir": subdir, "name": name, "relation": "conflict", "verdict": verdict,
        "status_fof": "Theorem", "status_smt": ("sat" if verdict == "Compatible" else "unsat"),
        "difficulty": "Easy", "includes": INC, "tptp_lang": "fof", "needs_density": False,
        "description": descr, "ttl": _ttl(kind, offer, branches),
        "fof_extra_decls": order_block(consts), "fof_conjecture": conj,
        "smt2_logic": "QF_LIA", "smt2_decls": "(declare-const x Int)", "smt2_asserts": asserts,
    }

B = [("gteq", "jun1"), ("gteq", "aug1")]   # shared branch pair: gteq 2026-06-01, gteq 2026-08-01
PROBLEMS = [
    _P("ODRL843", "or", "or(dateTime gteq 2026-06-01, gteq 2026-08-01) vs eq 2026-04-01 -> Conflict",
       "Conflict", "Offer 2026-04-01 satisfies neither gteq branch (Apr precedes Jun), so the union excludes it. Conflict.",
       ("eq", "apr1"), B),
    _P("ODRL844", "or", "or(dateTime gteq 2026-06-01, gteq 2026-08-01) vs eq 2026-09-01 -> Compatible",
       "Compatible", "Offer 2026-09-01 satisfies both gteq branches; the union includes it (witness exists). Compatible.",
       ("eq", "sep1"), B),
    _P("ODRL845", "or", "or(dateTime gteq 2026-06-01, gteq 2026-08-01) vs eq 2026-07-01 -> Compatible",
       "Compatible", "Offer 2026-07-01 satisfies the first branch (>= Jun) but not the second; the union includes it. Compatible.",
       ("eq", "jul1"), B),
    _P("ODRL846", "xone", "xone(dateTime gteq 2026-06-01, gteq 2026-08-01) vs eq 2026-09-01 -> Conflict",
       "Conflict", "Offer 2026-09-01 satisfies BOTH gteq branches, so exactly-one fails. xone excludes it (vs ODRL844 or). Conflict.",
       ("eq", "sep1"), B),
    _P("ODRL847", "xone", "xone(dateTime gteq 2026-06-01, gteq 2026-08-01) vs eq 2026-07-01 -> Compatible",
       "Compatible", "Offer 2026-07-01 satisfies exactly one branch (>= Jun, not >= Aug). xone includes it. Compatible.",
       ("eq", "jul1"), B),
    _P("ODRL848", "xone", "xone(dateTime gteq 2026-06-01, gteq 2026-08-01) vs eq 2026-04-01 -> Conflict",
       "Conflict", "Offer 2026-04-01 satisfies neither branch (zero, not exactly one). xone excludes it. Conflict.",
       ("eq", "apr1"), B),
]