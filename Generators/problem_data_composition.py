"""
problem_data_composition.py -- and-combinator Composition + BSB-BnF verdict vector.
The ODRL `and` combinator composes per-operand verdicts by Kleene min over policy_verdict
(conflict<unknown<compatible). Composition (859-862, subdir Composition) tests the min FOLD
over THREE operands directly (the missing combinator: or/xone/andSequence had categories, `and`
was only implicit in Capstone). Capstone verdict vector (863-864, subdir Capstone) reproduces
the paper's BSB-BnF running-example table as the four-operand vector
[dateTime, elapsedTime, delayPeriod, timeInterval] folded to the overall verdict -- 863 is the
running example itself (conflict,compatible,unknown,conflict -> Conflict, the headline Table),
864 the same structure with the two conflicts removed (-> Unknown, since delayPeriod stays
silent). policy_verdict is binary in DENOT000 and Kleene min is associative+commutative, so the
left fold is sound and order-independent. SMT: verdicts Int conflict=0<unknown=1<compatible=2,
min = nested (ite (<= a b) a b), refute the negation -> unsat.
"""
INC = ["ORD000-0.ax", "DENOT000-0.ax"]
VNUM = {"conflict": 0, "unknown": 1, "compatible": 2}

def fold_fof(vs):
    e = vs[0]
    for v in vs[1:]:
        e = f"policy_verdict({e}, {v})"
    return e

def fold_smt(vs):
    e = str(VNUM[vs[0]])
    for v in vs[1:]:
        n = VNUM[v]
        e = f"(ite (<= {e} {n}) {e} {n})"
    return e

def _P(pid, subdir, name, verdict, descr, vs, expected, ttl):
    return {
        "id": pid, "subdir": subdir, "name": name, "relation": "verdict", "verdict": verdict,
        "status_fof": "Theorem", "status_smt": "unsat", "difficulty": "Easy",
        "includes": INC, "tptp_lang": "fof", "needs_density": False,
        "description": descr, "ttl": ttl, "fof_extra_decls": "",
        "fof_conjecture": f"{fold_fof(vs)} = {expected}",
        "smt2_logic": "QF_LIA", "smt2_decls": "",
        "smt2_asserts": f"(assert (not (= {fold_smt(vs)} {VNUM[expected]})))",
    }

PFX = "@prefix odrl: <http://www.w3.org/ns/odrl/2/> .\n@prefix xsd:  <http://www.w3.org/2001/XMLSchema#> .\n@prefix drk:  <http://w3id.org/drk/ontology/> .\n"
def _atom(op, lo, val):
    dt = "xsd:dateTime" if lo == "dateTime" else "xsd:duration"
    return f'        [ odrl:leftOperand odrl:{lo} ; odrl:operator odrl:{op} ; odrl:rightOperand "{val}"^^{dt} ]\n'
def pol(name, atoms):  # atoms = list of (op, operand, value); >=2 -> odrl:and
    if len(atoms) == 1:
        op, lo, val = atoms[0]
        dt = "xsd:dateTime" if lo == "dateTime" else "xsd:duration"
        body = f'    odrl:constraint [ odrl:leftOperand odrl:{lo} ; odrl:operator odrl:{op} ; odrl:rightOperand "{val}"^^{dt} ]'
    else:
        body = "    odrl:constraint [\n      odrl:and (\n" + "".join(_atom(*a) for a in atoms) + "      )\n    ]"
    return f"drk:{name} a odrl:Set ;\n  odrl:permission [\n    odrl:action odrl:use ;\n{body}\n  ] .\n"
def pair(off, req, c1="# offer", c2="# request"):
    return PFX + c1 + "\n" + pol("policyA", off) + c2 + "\n" + pol("policyB", req)

D = "2026-06-01T00:00:00"
PROBLEMS = [
    # ---- Composition: the and-min fold over three operands ----
    _P("ODRL859", "Composition", "and over three compatible operands -> Compatible", "Compatible",
       "Offer and request agree on all three operands (dateTime, elapsedTime, delayPeriod), so each per-operand verdict is compatible and the and-fold is compatible.",
       ["compatible", "compatible", "compatible"], "compatible",
       pair([("eq","dateTime",D),("lteq","elapsedTime","P10D"),("gteq","delayPeriod","P1D")],
            [("eq","dateTime",D),("lteq","elapsedTime","P10D"),("gteq","delayPeriod","P1D")])),
    _P("ODRL860", "Composition", "one conflicting operand dominates the and-fold -> Conflict", "Conflict",
       "dateTime is disjoint (offer eq 2026-08-01 vs request eq 2027-01-01) while elapsedTime and delayPeriod are compatible; the and-fold is conflict (conflict is the Kleene bottom).",
       ["conflict", "compatible", "compatible"], "conflict",
       pair([("eq","dateTime","2026-08-01T00:00:00"),("lteq","elapsedTime","P10D"),("gteq","delayPeriod","P1D")],
            [("eq","dateTime","2027-01-01T00:00:00"),("lteq","elapsedTime","P10D"),("gteq","delayPeriod","P1D")])),
    _P("ODRL861", "Composition", "one silent operand makes the and-fold Unknown", "Unknown",
       "dateTime and elapsedTime are compatible; delayPeriod is constrained only by the offer (request silent) so it is unknown; with no conflict the and-fold is unknown.",
       ["compatible", "compatible", "unknown"], "unknown",
       pair([("eq","dateTime",D),("lteq","elapsedTime","P10D"),("gteq","delayPeriod","P1D")],
            [("eq","dateTime",D),("lteq","elapsedTime","P10D")])),
    _P("ODRL862", "Composition", "conflict dominates an unknown in the and-fold -> Conflict", "Conflict",
       "dateTime is disjoint (conflict), elapsedTime compatible, delayPeriod silent (unknown); conflict beats the unknown so the and-fold is conflict even with an unknown present.",
       ["conflict", "compatible", "unknown"], "conflict",
       pair([("eq","dateTime","2026-08-01T00:00:00"),("lteq","elapsedTime","P10D"),("gteq","delayPeriod","P1D")],
            [("eq","dateTime","2027-01-01T00:00:00"),("lteq","elapsedTime","P10D")])),
    # ---- Capstone verdict vector: the BSB-BnF running example (paper Table) ----
    _P("ODRL863", "Capstone", "BSB-BnF running example, four-operand verdict vector -> Conflict", "Conflict",
       ("The paper's BSB-BnF table as a verdict vector over [dateTime, elapsedTime, delayPeriod, timeInterval]\n"
        "= [conflict, compatible, unknown, conflict]: dateTime disjoint (2027-06-01 not < 2026-12-31),\n"
        "elapsedTime overlap [0,P10D], delayPeriod silent in the request (unknown), timeInterval disjoint cycles\n"
        "(gcd(30,45)=15 does not divide the 516-day offset). The and-fold over the four is Conflict."),
       ["conflict", "compatible", "unknown", "conflict"], "conflict",
       pair([("lt","dateTime","2026-12-31T00:00:00"),("lteq","elapsedTime","P30D"),("gteq","delayPeriod","P1D"),("eq","timeInterval","P30D")],
            [("eq","dateTime","2027-06-01T00:00:00"),("lteq","elapsedTime","P10D"),("eq","timeInterval","P45D")],
            "# BSB offer (anchored 2026-01-01)", "# BnF request (anchored 2027-06-01)")),
    _P("ODRL864", "Capstone", "BSB-BnF structure with conflicts resolved -> Unknown", "Unknown",
       ("Same four-operand structure with the two conflicts removed: dateTime aligned (both eq 2026-06-01),\n"
        "timeInterval aligned (both eq P30D, shared anchor), elapsedTime overlap, delayPeriod still silent in\n"
        "the request. The vector is [compatible, compatible, unknown, compatible], so the and-fold is Unknown\n"
        "-- a single silent operand keeps the whole policy pair underdetermined."),
       ["compatible", "compatible", "unknown", "compatible"], "unknown",
       pair([("eq","dateTime",D),("lteq","elapsedTime","P30D"),("gteq","delayPeriod","P1D"),("eq","timeInterval","P30D")],
            [("eq","dateTime",D),("lteq","elapsedTime","P10D"),("eq","timeInterval","P30D")],
            "# offer (anchored 2026-06-01)", "# request (anchored 2026-06-01)")),
]