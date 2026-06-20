"""
problem_data_conflictcriterion.py  -- ConflictCriterion: ODRL831-836 (Ord tier, FOF).
Tests PREC000 directly via the disjoint/8 predicate (which unfolds to prec/4 endpoint
precedence over open/closed tags). Uses dateTime, the ONLY two-sided temporal operand
(Adm(dateTime)=all of O_I), so the two-sided intervals are admissible. Durations are
one-sided and could not express these.

The quartet 833-836 shares the SAME meeting instant i10 and flips verdict purely by the
endpoint tags (closed via gteq/lteq, open via gt/lt):
  cc touch -> share the instant -> Compatible (prec needs strict less)
  any open -> instant excluded   -> Conflict   (prec needs only leq)

Includes ORD000 (order) + PREC000 (prec/disjoint). TPTP conjecture = disjoint(...) for
Conflict, ~disjoint(...) for Compatible (Theorem). SMT = the dual witness form over Int
day-numbers (tags -> strict/non-strict bounds; sat = shared instant = Compatible).
Instants i0..i20 map to 2026-01-01 + that many days.
"""
VAL = {"i0": 0, "i5": 5, "i10": 10, "i15": 15, "i20": 20}
ISO = {"i0": "2026-01-01", "i5": "2026-01-06", "i10": "2026-01-11",
       "i15": "2026-01-16", "i20": "2026-01-21"}
INC = ["ORD000-0.ax", "PREC000-0.ax"]

def _order_block(consts):
    cs = sorted(set(consts), key=lambda c: VAL[c])
    lines = []
    for i in range(len(cs)):
        for j in range(i + 1, len(cs)):
            lines.append(f"fof(ord_{cs[i]}_{cs[j]}, axiom, less({cs[i]}, {cs[j]})).")
    lines.append(f"fof(distinct, axiom, $distinct({', '.join(cs)})).")
    return "\n".join(lines) + "\n"

def _disjoint_atom(i1, i2):
    (L1, CL1, U1, CU1) = i1
    (L2, CL2, U2, CU2) = i2
    return f"disjoint({L1}, {U1}, {CL1}, {CU1}, {L2}, {U2}, {CL2}, {CU2})"

def _member_smt(iv):
    (Ln, Lt, Un, Ut) = iv
    lo = ">=" if Lt == "c" else ">"
    hi = "<=" if Ut == "c" else "<"
    return f"(assert ({lo} x {VAL[Ln]}))\n(assert ({hi} x {VAL[Un]}))"

def _ttl(i1, i2):
    def pol(name, iv):
        (Ln, Lt, Un, Ut) = iv
        lo = "gteq" if Lt == "c" else "gt"
        hi = "lteq" if Ut == "c" else "lt"
        return (f"drk:{name} a odrl:Set ;\n  odrl:permission [\n    odrl:action odrl:use ;\n"
                f"    odrl:constraint [\n      odrl:and (\n"
                f'        [ odrl:leftOperand odrl:dateTime ; odrl:operator odrl:{lo} ; '
                f'odrl:rightOperand "{ISO[Ln]}T00:00:00"^^xsd:dateTime ]\n'
                f'        [ odrl:leftOperand odrl:dateTime ; odrl:operator odrl:{hi} ; '
                f'odrl:rightOperand "{ISO[Un]}T00:00:00"^^xsd:dateTime ]\n'
                f"      )\n    ]\n  ] .")
    return ("@prefix odrl: <http://www.w3.org/ns/odrl/2/> .\n"
            "@prefix xsd:  <http://www.w3.org/2001/XMLSchema#> .\n"
            "@prefix drk:  <http://w3id.org/drk/ontology/> .\n"
            + pol("policyA", i1) + "\n" + pol("policyB", i2))

def _P(pid, name, verdict, descr, i1, i2):
    consts = [i1[0], i1[2], i2[0], i2[2]]
    atom = _disjoint_atom(i1, i2)
    if verdict == "Conflict":
        conj, smt_status = atom, "unsat"
    else:
        conj, smt_status = f"~( {atom} )", "sat"
    return {
        "id": pid, "subdir": "ConflictCriterion", "name": name,
        "relation": "conflict", "verdict": verdict,
        "status_fof": "Theorem", "status_smt": smt_status, "difficulty": "Easy",
        "includes": INC, "tptp_lang": "fof", "needs_density": False,
        "description": descr, "ttl": _ttl(i1, i2), "fof_extra_decls": _order_block(consts),
        "fof_conjecture": conj,
        "smt2_logic": "QF_LIA", "smt2_decls": "(declare-const x Int)",
        "smt2_asserts": _member_smt(i1) + "\n" + _member_smt(i2),
    }

# interval = (Lname, Ltag, Uname, Utag)  -- dateTime, two-sided
PROBLEMS = [
    _P("ODRL831", "[i0,i5] vs [i10,i15] -> Conflict (separated)", "Conflict",
       ("dateTime in [i0,i5] vs [i10,i15]. The upper of the first (i5, closed) strictly\n"
        "precedes the lower of the second (i10): prec(i5,i10,c,c) <=> less(i5,i10).\n"
        "Disjoint -> Conflict."),
       ("i0", "c", "i5", "c"), ("i10", "c", "i15", "c")),
    _P("ODRL832", "[i0,i10] vs [i5,i15] -> Compatible (overlap)", "Compatible",
       ("dateTime in [i0,i10] vs [i5,i15]; overlap on [i5,i10]. Neither prec holds, so\n"
        "not disjoint -> Compatible."),
       ("i0", "c", "i10", "c"), ("i5", "c", "i15", "c")),
    _P("ODRL833", "[i0,i10] vs [i10,i20], both closed at i10 -> Compatible", "Compatible",
       ("dateTime in [i0,i10] (closed upper) vs [i10,i20] (closed lower). They meet at\n"
        "i10 and both include it: prec(i10,i10,c,c) <=> less(i10,i10) is FALSE. The\n"
        "instant i10 is shared -> not disjoint -> Compatible."),
       ("i0", "c", "i10", "c"), ("i10", "c", "i20", "c")),
    _P("ODRL834", "[i0,i10) vs [i10,i20], first open at i10 -> Conflict", "Conflict",
       ("dateTime in [i0,i10) (OPEN upper, via lt) vs [i10,i20] (closed lower). The first\n"
        "excludes i10: prec(i10,i10,o,c) <=> leq(i10,i10) is TRUE. No shared instant ->\n"
        "disjoint -> Conflict (open upper flips 833)."),
       ("i0", "c", "i10", "o"), ("i10", "c", "i20", "c")),
    _P("ODRL835", "[i0,i10] vs (i10,i20], second open at i10 -> Conflict", "Conflict",
       ("dateTime in [i0,i10] (closed upper) vs (i10,i20] (OPEN lower, via gt). The second\n"
        "excludes i10: prec(i10,i10,c,o) <=> leq(i10,i10) is TRUE. Disjoint -> Conflict."),
       ("i0", "c", "i10", "c"), ("i10", "o", "i20", "c")),
    _P("ODRL836", "[i0,i10) vs (i10,i20], both open at i10 -> Conflict", "Conflict",
       ("dateTime in [i0,i10) (open upper) vs (i10,i20] (open lower). Neither includes\n"
        "i10: prec(i10,i10,o,o) <=> leq(i10,i10) is TRUE. Disjoint -> Conflict."),
       ("i0", "c", "i10", "o"), ("i10", "o", "i20", "c")),
]