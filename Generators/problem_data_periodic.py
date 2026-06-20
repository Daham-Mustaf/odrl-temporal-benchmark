"""
problem_data_periodic.py
========================
Periodic benchmark problems: ODRL816-820 (5 problems).
timeInterval operand (Dur, periodic, admits only eq). Mod tier.

A timeInterval eq P anchored at A denotes the recurring schedule
{ A + P*k : k >= 0 }. Two periodic constraints are Compatible iff their
schedules share an access instant, i.e. gcd(P1,P2) | (A2 - A1); Conflict
otherwise.

The recurrence is inlined with LITERAL periods so every instance is linear
(Presburger), the correct shape for the Mod tier:
  TPTP (.p, TFF / $int), self-contained (no axiom include):
    Compatible -> ?[T,K,M:$int]: (K>=0 & M>=0 & T=A1+P1*K & T=A2+P2*M)   (Theorem)
    Conflict   -> ![T,K,M:$int]: ~(K>=0 & M>=0 & T=A1+P1*K & T=A2+P2*M)  (Theorem)
  SMT (.smt2, QF_LIA): the same recurrence with k,m >= 0 (Int).
    sat = Compatible, unsat = Conflict.
PER000-0.ax documents the recurs/3 semantics but is not included (its generic
form is nonlinear; problems use the linear per-period instance).

Anchors are day offsets from a common origin (2026-01-01 = 0); periods are
day counts (P30D = 30, P45D = 45). 2027-06-01 = day 516.
"""

def _ttl(pA, anchorA_iso, pB, anchorB_iso):
    return f"""\
@prefix odrl: <http://www.w3.org/ns/odrl/2/> .
@prefix xsd:  <http://www.w3.org/2001/XMLSchema#> .
@prefix drk:  <http://w3id.org/drk/ontology/> .
drk:policyA a odrl:Set ;
  odrl:permission [
    odrl:action odrl:use ;
    odrl:constraint [
      odrl:leftOperand odrl:timeInterval ;
      odrl:operator odrl:eq ;
      odrl:rightOperand "{pA}"^^xsd:duration ;
      drk:anchor "{anchorA_iso}"^^xsd:date ]
  ] .
drk:policyB a odrl:Set ;
  odrl:permission [
    odrl:action odrl:use ;
    odrl:constraint [
      odrl:leftOperand odrl:timeInterval ;
      odrl:operator odrl:eq ;
      odrl:rightOperand "{pB}"^^xsd:duration ;
      drk:anchor "{anchorB_iso}"^^xsd:date ]
  ] ."""

def _rec(a, p, var):  # T = a + p*var   (linear: p is a literal)
    return f"T = $sum({a}, $product({p}, {var}))"

def _compat(a1, p1, a2, p2):
    return (f"?[T:$int,K:$int,M:$int]: ($greatereq(K,0) & $greatereq(M,0) & "
            f"{_rec(a1,p1,'K')} & {_rec(a2,p2,'M')})")

def _conflict(a1, p1, a2, p2):
    return (f"![T:$int,K:$int,M:$int]: ~($greatereq(K,0) & $greatereq(M,0) & "
            f"{_rec(a1,p1,'K')} & {_rec(a2,p2,'M')})")

def _smt(a1, p1, a2, p2):
    return (f"(assert (>= k 0))\n(assert (>= m 0))\n"
            f"(assert (= t (+ {a1} (* {p1} k))))\n"
            f"(assert (= t (+ {a2} (* {p2} m))))")

DECLS = "(declare-const t Int)\n(declare-const k Int)\n(declare-const m Int)"

def _P(pid, name, verdict, smt_status, diff, descr, ttl, conj, asserts):
    return {
        "id": pid, "subdir": "Periodic", "name": name,
        "relation": "conflict", "verdict": verdict,
        "status_fof": "Theorem", "status_smt": smt_status, "difficulty": diff,
        "includes": [], "tptp_lang": "tff", "needs_density": False,
        "description": descr, "ttl": ttl,
        "fof_extra_decls": "", "fof_conjecture": conj,
        "smt2_logic": "QF_LIA", "smt2_decls": DECLS, "smt2_asserts": asserts,
    }

PROBLEMS = [
    _P("ODRL816", "timeInterval eq P30D & eq P45D, aligned anchors -> Compatible",
       "Compatible", "sat", "Medium",
       ("timeInterval eq P30D (anchor 2026-01-01) & eq P45D (anchor 2026-01-01).\n"
        "Offset 0; gcd(30,45)=15 divides 0, so the schedules coincide (e.g. day 90)."),
       _ttl("P30D","2026-01-01","P45D","2026-01-01"),
       _compat(0,30,0,45), _smt(0,30,0,45)),
    _P("ODRL817", "timeInterval eq P30D & eq P45D, offset 1 -> Conflict",
       "Conflict", "unsat", "Medium",
       ("timeInterval eq P30D (anchor day 0) & eq P45D (anchor day 1).\n"
        "Offset 1; gcd(30,45)=15 does not divide 1, so the schedules never coincide."),
       _ttl("P30D","2026-01-01","P45D","2026-01-02"),
       _conflict(0,30,1,45), _smt(0,30,1,45)),
    _P("ODRL818", "timeInterval eq P30D & eq P30D, offset 15 -> Conflict",
       "Conflict", "unsat", "Medium",
       ("timeInterval eq P30D (anchor day 0) & eq P30D (anchor day 15).\n"
        "Same period 30, offset 15; 30 does not divide 15, so the cycles never align."),
       _ttl("P30D","2026-01-01","P30D","2026-01-16"),
       _conflict(0,30,15,30), _smt(0,30,15,30)),
    _P("ODRL819", "timeInterval eq P30D & eq P30D, offset 60 -> Compatible",
       "Compatible", "sat", "Medium",
       ("timeInterval eq P30D (anchor day 0) & eq P30D (anchor day 60).\n"
        "Same period 30, offset 60; 30 divides 60, so the cycles coincide (e.g. day 60)."),
       _ttl("P30D","2026-01-01","P30D","2026-03-02"),
       _compat(0,30,60,30), _smt(0,30,60,30)),
    _P("ODRL820", "timeInterval eq P30D & eq P45D, BSB-BnF offset 516 -> Conflict",
       "Conflict", "unsat", "Hard",
       ("BSB-BnF timeInterval layer: eq P30D (anchor 2026-01-01) & eq P45D\n"
        "(anchor 2027-06-01 = day 516). gcd(30,45)=15, 516 mod 15 = 6, so 15 does not\n"
        "divide 516: the recurring schedules never coincide. The periodic layer alone\n"
        "already conflicts."),
       _ttl("P30D","2026-01-01","P45D","2027-06-01"),
       _conflict(0,30,516,45), _smt(0,30,516,45)),
]