"""
problem_data_refinement.py  -- Refinement: ODRL852-855 (Ord/FOF).
Policy entailment C1 <= C2 (Lem. refine-syntax): C1 refines C2 iff C1's interval is
contained in C2's, i.e. interval_subsumes(L1,U1,L2,U2) <=> leq(L2,L1) & leq(U1,U2).
Proves the subsumption (Refines) or its negation (NotRefines), exercising the DENOT000
interval_subsumes predicate (otherwise unused). dateTime instants i_N = 2026-01-01 + N
days, ordered via ORD000 (FOF, so Vampire AND E both solve).
"""
INC = ["ORD000-0.ax", "DENOT000-0.ax"]
VAL = {"i0": 0, "i5": 5, "i10": 10, "i15": 15, "i20": 20}
ISO = {"i0": "2026-01-01", "i5": "2026-01-06", "i10": "2026-01-11", "i15": "2026-01-16", "i20": "2026-01-21"}

def order_block(consts):
    cs = sorted(set(consts), key=lambda c: VAL[c])
    L = [f"fof(ord_{cs[i]}_{cs[i+1]}, axiom, less({cs[i]}, {cs[i+1]}))." for i in range(len(cs) - 1)]
    L.append(f"fof(distinct, axiom, $distinct({', '.join(cs)})).")
    return "\n".join(L) + "\n"

def _ttl(c1, c2):
    def pol(name, lo, hi):
        return (f"drk:{name} a odrl:Set ;\n  odrl:permission [\n    odrl:action odrl:use ;\n"
                f"    odrl:constraint [\n      odrl:and (\n"
                f'        [ odrl:leftOperand odrl:dateTime ; odrl:operator odrl:gteq ; odrl:rightOperand "{ISO[lo]}T00:00:00"^^xsd:dateTime ]\n'
                f'        [ odrl:leftOperand odrl:dateTime ; odrl:operator odrl:lteq ; odrl:rightOperand "{ISO[hi]}T00:00:00"^^xsd:dateTime ]\n'
                f"      )\n    ]\n  ] .")
    return ("@prefix odrl: <http://www.w3.org/ns/odrl/2/> .\n@prefix xsd:  <http://www.w3.org/2001/XMLSchema#> .\n@prefix drk:  <http://w3id.org/drk/ontology/> .\n"
            "# C1: the candidate refinement (narrower window)\n" + pol("policyC1", *c1) +
            "\n# C2: the policy it is checked against (wider window)\n" + pol("policyC2", *c2))

def _P(pid, name, verdict, descr, c1, c2, refines):
    L1, U1 = c1
    L2, U2 = c2
    atom = f"interval_subsumes({L1}, {U1}, {L2}, {U2})"
    cond = f"(and (<= {VAL[L2]} {VAL[L1]}) (<= {VAL[U1]} {VAL[U2]}))"
    return {
        "id": pid, "subdir": "Refinement", "name": name, "relation": "refinement", "verdict": verdict,
        "status_fof": "Theorem", "status_smt": "unsat", "difficulty": "Easy",
        "includes": INC, "tptp_lang": "fof", "needs_density": False,
        "description": descr, "ttl": _ttl(c1, c2),
        "fof_extra_decls": order_block([L1, U1, L2, U2]),
        "fof_conjecture": atom if refines else f"~( {atom} )",
        "smt2_logic": "QF_LIA", "smt2_decls": "",
        "smt2_asserts": (f"(assert (not {cond}))" if refines else f"(assert {cond})"),
    }

PROBLEMS = [
    _P("ODRL852", "[i0,i5] refines [i0,i10] -> Refines", "Refines",
       "dateTime window [2026-01-01,2026-01-06] is contained in [2026-01-01,2026-01-11] (same lower, tighter upper). interval_subsumes holds. Refines.",
       ("i0", "i5"), ("i0", "i10"), True),
    _P("ODRL853", "[i0,i20] does not refine [i0,i10] -> NotRefines", "NotRefines",
       "dateTime window [2026-01-01,2026-01-21] is NOT contained in [2026-01-01,2026-01-11] (upper 21 > 11). interval_subsumes fails. NotRefines.",
       ("i0", "i20"), ("i0", "i10"), False),
    _P("ODRL854", "[i5,i10] refines [i0,i15] -> Refines", "Refines",
       "dateTime window [2026-01-06,2026-01-11] is contained in [2026-01-01,2026-01-16] (both bounds inside). interval_subsumes holds. Refines.",
       ("i5", "i10"), ("i0", "i15"), True),
    _P("ODRL855", "[i0,i10] does not refine [i5,i15] -> NotRefines", "NotRefines",
       "dateTime window [2026-01-01,2026-01-11] is NOT contained in [2026-01-06,2026-01-16] (lower 1 < 6). interval_subsumes fails. NotRefines.",
       ("i0", "i10"), ("i5", "i15"), False),
]