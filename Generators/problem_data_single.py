"""
problem_data_single.py
======================
SingleOperand benchmark problems: ODRL800-807 (8 problems).
One temporal operand, two constraints (two policies), conflict-criterion test.
Temporal analogue of AxisDecomposition's SingleAxis.

Operand encodings (paper def:interval-denotation):
  dateTime  (instant, no floor):  lteq t -> leq(X,t)  lt t -> less(X,t)
                                  gteq t -> leq(t,X)  gt t -> less(t,X)
                                  eq t  -> in_closed(X,t,t)
  elapsedTime (duration, floor d0 = 0, closed): lteq v -> in_closed(X,d0,v)
                                  lt v -> in_ropen(X,d0,v)  gteq v -> leq(v,X)
                                  gt v -> less(v,X)         eq v -> in_closed(X,v,v)
Conjecture (witness form):
  Conflict   -> ![X]: ~(m1 & m2)   (Theorem / unsat: no shared point)
  Compatible -> ?[X]:  (m1 & m2)   (Theorem / sat:  a shared point exists)
dateTime values use order-preserving YYYYMMDD integers; durations use day counts.
TTL prefix: drk: <http://w3id.org/drk/ontology/>
"""

def _ttl(opA, valA, isoA, opB, valB, isoB, operand, dt):
    typ = "xsd:dateTime" if dt else "xsd:duration"
    return f"""\
@prefix odrl: <http://www.w3.org/ns/odrl/2/> .
@prefix xsd:  <http://www.w3.org/2001/XMLSchema#> .
@prefix drk:  <http://w3id.org/drk/ontology/> .
drk:policyA a odrl:Set ;
  odrl:permission [
    odrl:action odrl:use ;
    odrl:constraint [
      odrl:leftOperand odrl:{operand} ;
      odrl:operator odrl:{opA} ;
      odrl:rightOperand "{isoA}"^^{typ} ]
  ] .
drk:policyB a odrl:Set ;
  odrl:permission [
    odrl:action odrl:use ;
    odrl:constraint [
      odrl:leftOperand odrl:{operand} ;
      odrl:operator odrl:{opB} ;
      odrl:rightOperand "{isoB}"^^{typ} ]
  ] ."""

PROBLEMS = [
    # ---- dateTime (instant) ----
    {
        "id": "ODRL800", "subdir": "SingleOperand",
        "name": "dateTime lteq 2026-12-31 & gteq 2027-06-01 -> Conflict",
        "relation": "conflict", "verdict": "Conflict",
        "status_fof": "Theorem", "status_smt": "unsat", "difficulty": "Easy",
        "includes": ["ORD000-0.ax", "DENOT000-0.ax"], "needs_density": False,
        "description": ("dateTime: lteq 2026-12-31 -> (-inf,t2]   gteq 2027-06-01 -> [t3,+inf)\n"
                        "t2 < t3 so the bounds cross: no instant satisfies both. Conflict."),
        "ttl": _ttl("lteq","20261231","2026-12-31T00:00:00","gteq","20270601","2027-06-01T00:00:00","dateTime",True),
        "fof_extra_decls": ("fof(ord_t2_t3, axiom, less(d20261231, d20270601)).\n"
                            "fof(distinct,  axiom, $distinct(d20261231, d20270601)).\n"),
        "fof_conjecture": "![X]: ~(leq(X, d20261231) & leq(d20270601, X))",
        "smt2_logic": "QF_LRA", "smt2_decls": "(declare-const x Real)",
        "smt2_asserts": "(assert (<= x 20261231.0))\n(assert (>= x 20270601.0))",
    },
    {
        "id": "ODRL801", "subdir": "SingleOperand",
        "name": "dateTime gteq 2026-06-01 & lteq 2027-06-01 -> Compatible",
        "relation": "conflict", "verdict": "Compatible",
        "status_fof": "Theorem", "status_smt": "sat", "difficulty": "Easy",
        "includes": ["ORD000-0.ax", "DENOT000-0.ax"], "needs_density": False,
        "description": ("dateTime: gteq 2026-06-01 -> [t1,+inf)   lteq 2027-06-01 -> (-inf,t3]\n"
                        "[t1,t3] is non-empty (witness t1). Compatible."),
        "ttl": _ttl("gteq","20260601","2026-06-01T00:00:00","lteq","20270601","2027-06-01T00:00:00","dateTime",True),
        "fof_extra_decls": ("fof(ord_t1_t3, axiom, less(d20260601, d20270601)).\n"
                            "fof(distinct,  axiom, $distinct(d20260601, d20270601)).\n"),
        "fof_conjecture": "?[X]: (leq(d20260601, X) & leq(X, d20270601))",
        "smt2_logic": "QF_LRA", "smt2_decls": "(declare-const x Real)",
        "smt2_asserts": "(assert (>= x 20260601.0))\n(assert (<= x 20270601.0))",
    },
    {
        "id": "ODRL802", "subdir": "SingleOperand",
        "name": "dateTime lt 2026-12-31 & gt 2026-12-31 -> Conflict",
        "relation": "conflict", "verdict": "Conflict",
        "status_fof": "Theorem", "status_smt": "unsat", "difficulty": "Easy",
        "includes": ["ORD000-0.ax", "DENOT000-0.ax"], "needs_density": False,
        "description": ("dateTime: lt 2026-12-31 -> (-inf,t)   gt 2026-12-31 -> (t,+inf)\n"
                        "Strict bounds at the same instant: no X with X<t and t<X. Conflict."),
        "ttl": _ttl("lt","20261231","2026-12-31T00:00:00","gt","20261231","2026-12-31T00:00:00","dateTime",True),
        "fof_extra_decls": "",
        "fof_conjecture": "![X]: ~(less(X, d20261231) & less(d20261231, X))",
        "smt2_logic": "QF_LRA", "smt2_decls": "(declare-const x Real)",
        "smt2_asserts": "(assert (< x 20261231.0))\n(assert (> x 20261231.0))",
    },
    {
        "id": "ODRL803", "subdir": "SingleOperand",
        "name": "dateTime gt 2026-06-01 & lt 2027-06-01 -> Compatible (open, density)",
        "relation": "conflict", "verdict": "Compatible",
        "status_fof": "Theorem", "status_smt": "sat", "difficulty": "Medium",
        "includes": ["ORD000-0.ax", "ORD001-0.ax", "DENOT000-0.ax"], "needs_density": True,
        "description": ("dateTime: gt 2026-06-01 -> (t1,+inf)   lt 2027-06-01 -> (-inf,t3)\n"
                        "Open interval (t1,t3); a witness strictly between exists only by density.\n"
                        "Requires ORD001-0.ax."),
        "ttl": _ttl("gt","20260601","2026-06-01T00:00:00","lt","20270601","2027-06-01T00:00:00","dateTime",True),
        "fof_extra_decls": ("fof(ord_t1_t3, axiom, less(d20260601, d20270601)).\n"
                            "fof(distinct,  axiom, $distinct(d20260601, d20270601)).\n"),
        "fof_conjecture": "?[X]: (less(d20260601, X) & less(X, d20270601))",
        "smt2_logic": "QF_LRA", "smt2_decls": "(declare-const x Real)",
        "smt2_asserts": "(assert (> x 20260601.0))\n(assert (< x 20270601.0))",
    },
    # ---- elapsedTime (duration, floor d0) ----
    {
        "id": "ODRL804", "subdir": "SingleOperand",
        "name": "elapsedTime lteq P600D & eq P1200D -> Conflict",
        "relation": "conflict", "verdict": "Conflict",
        "status_fof": "Theorem", "status_smt": "unsat", "difficulty": "Easy",
        "includes": ["ORD000-0.ax", "DUR000-0.ax", "DENOT000-0.ax"], "needs_density": False,
        "description": ("elapsedTime: lteq P600D -> [0,600]   eq P1200D -> {1200}\n"
                        "1200 > 600 so the required point lies outside the cap. Conflict."),
        "ttl": _ttl("lteq","P600D","P600D","eq","P1200D","P1200D","elapsedTime",False),
        "fof_extra_decls": ("fof(dur_d0,    axiom, dur(d0)).\n"
                            "fof(dur_p600,  axiom, dur(p600)).\n"
                            "fof(dur_p1200, axiom, dur(p1200)).\n"
                            "fof(ord_d0_p600,    axiom, less(d0, p600)).\n"
                            "fof(ord_d0_p1200,   axiom, less(d0, p1200)).\n"
                            "fof(ord_p600_p1200, axiom, less(p600, p1200)).\n"
                            "fof(distinct, axiom, $distinct(d0, p600, p1200)).\n"),
        "fof_conjecture": "![X]: ~(in_closed(X, d0, p600) & in_closed(X, p1200, p1200))",
        "smt2_logic": "QF_LRA", "smt2_decls": "(declare-const x Real)",
        "smt2_asserts": "(assert (<= 0.0 x))\n(assert (<= x 600.0))\n(assert (= x 1200.0))",
    },
    {
        "id": "ODRL805", "subdir": "SingleOperand",
        "name": "elapsedTime lteq P1200D & eq P600D -> Compatible",
        "relation": "conflict", "verdict": "Compatible",
        "status_fof": "Theorem", "status_smt": "sat", "difficulty": "Easy",
        "includes": ["ORD000-0.ax", "DUR000-0.ax", "DENOT000-0.ax"], "needs_density": False,
        "description": ("elapsedTime: lteq P1200D -> [0,1200]   eq P600D -> {600}\n"
                        "600 <= 1200 so the required point lies within the cap. Compatible."),
        "ttl": _ttl("lteq","P1200D","P1200D","eq","P600D","P600D","elapsedTime",False),
        "fof_extra_decls": ("fof(dur_d0,    axiom, dur(d0)).\n"
                            "fof(dur_p600,  axiom, dur(p600)).\n"
                            "fof(dur_p1200, axiom, dur(p1200)).\n"
                            "fof(ord_d0_p600,    axiom, less(d0, p600)).\n"
                            "fof(ord_d0_p1200,   axiom, less(d0, p1200)).\n"
                            "fof(ord_p600_p1200, axiom, less(p600, p1200)).\n"
                            "fof(distinct, axiom, $distinct(d0, p600, p1200)).\n"),
        "fof_conjecture": "?[X]: (in_closed(X, d0, p1200) & in_closed(X, p600, p600))",
        "smt2_logic": "QF_LRA", "smt2_decls": "(declare-const x Real)",
        "smt2_asserts": "(assert (<= 0.0 x))\n(assert (<= x 1200.0))\n(assert (= x 600.0))",
    },
    {
        "id": "ODRL806", "subdir": "SingleOperand",
        "name": "elapsedTime eq P600D & lteq P300D -> Conflict",
        "relation": "conflict", "verdict": "Conflict",
        "status_fof": "Theorem", "status_smt": "unsat", "difficulty": "Easy",
        "includes": ["ORD000-0.ax", "DUR000-0.ax", "DENOT000-0.ax"], "needs_density": False,
        "description": ("elapsedTime: eq P600D -> {600}   lteq P300D -> [0,300]\n"
                        "600 > 300 so {600} is outside [0,300]. Conflict."),
        "ttl": _ttl("eq","P600D","P600D","lteq","P300D","P300D","elapsedTime",False),
        "fof_extra_decls": ("fof(dur_d0,   axiom, dur(d0)).\n"
                            "fof(dur_p300, axiom, dur(p300)).\n"
                            "fof(dur_p600, axiom, dur(p600)).\n"
                            "fof(ord_d0_p300,   axiom, less(d0, p300)).\n"
                            "fof(ord_d0_p600,   axiom, less(d0, p600)).\n"
                            "fof(ord_p300_p600, axiom, less(p300, p600)).\n"
                            "fof(distinct, axiom, $distinct(d0, p300, p600)).\n"),
        "fof_conjecture": "![X]: ~(in_closed(X, p600, p600) & in_closed(X, d0, p300))",
        "smt2_logic": "QF_LRA", "smt2_decls": "(declare-const x Real)",
        "smt2_asserts": "(assert (= x 600.0))\n(assert (<= 0.0 x))\n(assert (<= x 300.0))",
    },
    {
        "id": "ODRL807", "subdir": "SingleOperand",
        "name": "elapsedTime eq P600D & lteq P1200D -> Compatible",
        "relation": "conflict", "verdict": "Compatible",
        "status_fof": "Theorem", "status_smt": "sat", "difficulty": "Easy",
        "includes": ["ORD000-0.ax", "DUR000-0.ax", "DENOT000-0.ax"], "needs_density": False,
        "description": ("elapsedTime: eq P600D -> {600}   lteq P1200D -> [0,1200]\n"
                        "600 in [0,1200] so {600} is inside. Compatible (witness 600)."),
        "ttl": _ttl("eq","P600D","P600D","lteq","P1200D","P1200D","elapsedTime",False),
        "fof_extra_decls": ("fof(dur_d0,    axiom, dur(d0)).\n"
                            "fof(dur_p600,  axiom, dur(p600)).\n"
                            "fof(dur_p1200, axiom, dur(p1200)).\n"
                            "fof(ord_d0_p600,    axiom, less(d0, p600)).\n"
                            "fof(ord_d0_p1200,   axiom, less(d0, p1200)).\n"
                            "fof(ord_p600_p1200, axiom, less(p600, p1200)).\n"
                            "fof(distinct, axiom, $distinct(d0, p600, p1200)).\n"),
        "fof_conjecture": "?[X]: (in_closed(X, p600, p600) & in_closed(X, d0, p1200))",
        "smt2_logic": "QF_LRA", "smt2_decls": "(declare-const x Real)",
        "smt2_asserts": "(assert (= x 600.0))\n(assert (<= 0.0 x))\n(assert (<= x 1200.0))",
    },
]

# ==========================================================================
# delayPeriod (Dur, lower-bound operators eq/gt/gteq) and meteredTime
# (Dur, upper-bound operators eq/lt/lteq, like elapsedTime). ODRL808-815.
# Completes the four Ord-tier interval operands. (timeInterval is periodic,
# Mod tier -> PER000, separate Periodic category.)
# ==========================================================================
PROBLEMS += [
    # ---- delayPeriod ----
    {
        "id": "ODRL808", "subdir": "SingleOperand",
        "name": "delayPeriod gteq P1D & gteq P5D -> Compatible",
        "relation": "conflict", "verdict": "Compatible",
        "status_fof": "Theorem", "status_smt": "sat", "difficulty": "Easy",
        "includes": ["ORD000-0.ax", "DUR000-0.ax", "DENOT000-0.ax"], "needs_density": False,
        "description": ("delayPeriod: gteq P1D -> [1,+inf)   gteq P5D -> [5,+inf)\n"
                        "Two lower bounds; effective delay max(1,5)=5 is satisfiable. Compatible."),
        "ttl": _ttl("gteq","P1D","P1D","gteq","P5D","P5D","delayPeriod",False),
        "fof_extra_decls": ("fof(dur_d0, axiom, dur(d0)).\n"
                            "fof(dur_p1, axiom, dur(p1)).\n"
                            "fof(dur_p5, axiom, dur(p5)).\n"
                            "fof(ord_d0_p1, axiom, less(d0, p1)).\n"
                            "fof(ord_d0_p5, axiom, less(d0, p5)).\n"
                            "fof(ord_p1_p5, axiom, less(p1, p5)).\n"
                            "fof(distinct, axiom, $distinct(d0, p1, p5)).\n"),
        "fof_conjecture": "?[X]: (leq(p1, X) & leq(p5, X))",
        "smt2_logic": "QF_LRA", "smt2_decls": "(declare-const x Real)",
        "smt2_asserts": "(assert (>= x 1.0))\n(assert (>= x 5.0))",
    },
    {
        "id": "ODRL809", "subdir": "SingleOperand",
        "name": "delayPeriod eq P1D & gteq P5D -> Conflict",
        "relation": "conflict", "verdict": "Conflict",
        "status_fof": "Theorem", "status_smt": "unsat", "difficulty": "Easy",
        "includes": ["ORD000-0.ax", "DUR000-0.ax", "DENOT000-0.ax"], "needs_density": False,
        "description": ("delayPeriod: eq P1D -> {1}   gteq P5D -> [5,+inf)\n"
                        "1 < 5 so the exact 1-day delay cannot also be at least 5. Conflict."),
        "ttl": _ttl("eq","P1D","P1D","gteq","P5D","P5D","delayPeriod",False),
        "fof_extra_decls": ("fof(dur_d0, axiom, dur(d0)).\n"
                            "fof(dur_p1, axiom, dur(p1)).\n"
                            "fof(dur_p5, axiom, dur(p5)).\n"
                            "fof(ord_d0_p1, axiom, less(d0, p1)).\n"
                            "fof(ord_d0_p5, axiom, less(d0, p5)).\n"
                            "fof(ord_p1_p5, axiom, less(p1, p5)).\n"
                            "fof(distinct, axiom, $distinct(d0, p1, p5)).\n"),
        "fof_conjecture": "![X]: ~(in_closed(X, p1, p1) & leq(p5, X))",
        "smt2_logic": "QF_LRA", "smt2_decls": "(declare-const x Real)",
        "smt2_asserts": "(assert (= x 1.0))\n(assert (>= x 5.0))",
    },
    {
        "id": "ODRL810", "subdir": "SingleOperand",
        "name": "delayPeriod eq P5D & gteq P1D -> Compatible",
        "relation": "conflict", "verdict": "Compatible",
        "status_fof": "Theorem", "status_smt": "sat", "difficulty": "Easy",
        "includes": ["ORD000-0.ax", "DUR000-0.ax", "DENOT000-0.ax"], "needs_density": False,
        "description": ("delayPeriod: eq P5D -> {5}   gteq P1D -> [1,+inf)\n"
                        "5 >= 1 so an exact 5-day delay satisfies the at-least-1 bound. Compatible."),
        "ttl": _ttl("eq","P5D","P5D","gteq","P1D","P1D","delayPeriod",False),
        "fof_extra_decls": ("fof(dur_d0, axiom, dur(d0)).\n"
                            "fof(dur_p1, axiom, dur(p1)).\n"
                            "fof(dur_p5, axiom, dur(p5)).\n"
                            "fof(ord_d0_p1, axiom, less(d0, p1)).\n"
                            "fof(ord_d0_p5, axiom, less(d0, p5)).\n"
                            "fof(ord_p1_p5, axiom, less(p1, p5)).\n"
                            "fof(distinct, axiom, $distinct(d0, p1, p5)).\n"),
        "fof_conjecture": "?[X]: (in_closed(X, p5, p5) & leq(p1, X))",
        "smt2_logic": "QF_LRA", "smt2_decls": "(declare-const x Real)",
        "smt2_asserts": "(assert (= x 5.0))\n(assert (>= x 1.0))",
    },
    {
        "id": "ODRL811", "subdir": "SingleOperand",
        "name": "delayPeriod eq P5D & gt P5D -> Conflict",
        "relation": "conflict", "verdict": "Conflict",
        "status_fof": "Theorem", "status_smt": "unsat", "difficulty": "Easy",
        "includes": ["ORD000-0.ax", "DUR000-0.ax", "DENOT000-0.ax"], "needs_density": False,
        "description": ("delayPeriod: eq P5D -> {5}   gt P5D -> (5,+inf)\n"
                        "An exact 5-day delay cannot be strictly greater than 5. Conflict."),
        "ttl": _ttl("eq","P5D","P5D","gt","P5D","P5D","delayPeriod",False),
        "fof_extra_decls": ("fof(dur_d0, axiom, dur(d0)).\n"
                            "fof(dur_p5, axiom, dur(p5)).\n"
                            "fof(ord_d0_p5, axiom, less(d0, p5)).\n"
                            "fof(distinct, axiom, $distinct(d0, p5)).\n"),
        "fof_conjecture": "![X]: ~(in_closed(X, p5, p5) & less(p5, X))",
        "smt2_logic": "QF_LRA", "smt2_decls": "(declare-const x Real)",
        "smt2_asserts": "(assert (= x 5.0))\n(assert (> x 5.0))",
    },
    # ---- meteredTime ----
    {
        "id": "ODRL812", "subdir": "SingleOperand",
        "name": "meteredTime lteq P10D & lteq P30D -> Compatible",
        "relation": "conflict", "verdict": "Compatible",
        "status_fof": "Theorem", "status_smt": "sat", "difficulty": "Easy",
        "includes": ["ORD000-0.ax", "DUR000-0.ax", "DENOT000-0.ax"], "needs_density": False,
        "description": ("meteredTime: lteq P10D -> [0,10]   lteq P30D -> [0,30]\n"
                        "[0,10] is non-empty (witness 0). Compatible."),
        "ttl": _ttl("lteq","P10D","P10D","lteq","P30D","P30D","meteredTime",False),
        "fof_extra_decls": ("fof(dur_d0, axiom, dur(d0)).\n"
                            "fof(dur_p10, axiom, dur(p10)).\n"
                            "fof(dur_p30, axiom, dur(p30)).\n"
                            "fof(ord_d0_p10, axiom, less(d0, p10)).\n"
                            "fof(ord_d0_p30, axiom, less(d0, p30)).\n"
                            "fof(ord_p10_p30, axiom, less(p10, p30)).\n"
                            "fof(distinct, axiom, $distinct(d0, p10, p30)).\n"),
        "fof_conjecture": "?[X]: (in_closed(X, d0, p10) & in_closed(X, d0, p30))",
        "smt2_logic": "QF_LRA", "smt2_decls": "(declare-const x Real)",
        "smt2_asserts": "(assert (>= x 0.0))\n(assert (<= x 10.0))\n(assert (<= x 30.0))",
    },
    {
        "id": "ODRL813", "subdir": "SingleOperand",
        "name": "meteredTime eq P30D & lteq P10D -> Conflict",
        "relation": "conflict", "verdict": "Conflict",
        "status_fof": "Theorem", "status_smt": "unsat", "difficulty": "Easy",
        "includes": ["ORD000-0.ax", "DUR000-0.ax", "DENOT000-0.ax"], "needs_density": False,
        "description": ("meteredTime: eq P30D -> {30}   lteq P10D -> [0,10]\n"
                        "30 > 10 so {30} is outside [0,10]. Conflict."),
        "ttl": _ttl("eq","P30D","P30D","lteq","P10D","P10D","meteredTime",False),
        "fof_extra_decls": ("fof(dur_d0, axiom, dur(d0)).\n"
                            "fof(dur_p10, axiom, dur(p10)).\n"
                            "fof(dur_p30, axiom, dur(p30)).\n"
                            "fof(ord_d0_p10, axiom, less(d0, p10)).\n"
                            "fof(ord_d0_p30, axiom, less(d0, p30)).\n"
                            "fof(ord_p10_p30, axiom, less(p10, p30)).\n"
                            "fof(distinct, axiom, $distinct(d0, p10, p30)).\n"),
        "fof_conjecture": "![X]: ~(in_closed(X, p30, p30) & in_closed(X, d0, p10))",
        "smt2_logic": "QF_LRA", "smt2_decls": "(declare-const x Real)",
        "smt2_asserts": "(assert (= x 30.0))\n(assert (>= x 0.0))\n(assert (<= x 10.0))",
    },
    {
        "id": "ODRL814", "subdir": "SingleOperand",
        "name": "meteredTime lt P10D & lteq P30D -> Compatible",
        "relation": "conflict", "verdict": "Compatible",
        "status_fof": "Theorem", "status_smt": "sat", "difficulty": "Easy",
        "includes": ["ORD000-0.ax", "DUR000-0.ax", "DENOT000-0.ax"], "needs_density": False,
        "description": ("meteredTime: lt P10D -> [0,10)   lteq P30D -> [0,30]\n"
                        "[0,10) is non-empty (witness 0). Compatible."),
        "ttl": _ttl("lt","P10D","P10D","lteq","P30D","P30D","meteredTime",False),
        "fof_extra_decls": ("fof(dur_d0, axiom, dur(d0)).\n"
                            "fof(dur_p10, axiom, dur(p10)).\n"
                            "fof(dur_p30, axiom, dur(p30)).\n"
                            "fof(ord_d0_p10, axiom, less(d0, p10)).\n"
                            "fof(ord_d0_p30, axiom, less(d0, p30)).\n"
                            "fof(ord_p10_p30, axiom, less(p10, p30)).\n"
                            "fof(distinct, axiom, $distinct(d0, p10, p30)).\n"),
        "fof_conjecture": "?[X]: (in_ropen(X, d0, p10) & in_closed(X, d0, p30))",
        "smt2_logic": "QF_LRA", "smt2_decls": "(declare-const x Real)",
        "smt2_asserts": "(assert (>= x 0.0))\n(assert (< x 10.0))\n(assert (<= x 30.0))",
    },
    {
        "id": "ODRL815", "subdir": "SingleOperand",
        "name": "meteredTime eq P10D & lt P10D -> Conflict",
        "relation": "conflict", "verdict": "Conflict",
        "status_fof": "Theorem", "status_smt": "unsat", "difficulty": "Easy",
        "includes": ["ORD000-0.ax", "DUR000-0.ax", "DENOT000-0.ax"], "needs_density": False,
        "description": ("meteredTime: eq P10D -> {10}   lt P10D -> [0,10)\n"
                        "10 is not strictly less than 10, so {10} is outside [0,10). Conflict."),
        "ttl": _ttl("eq","P10D","P10D","lt","P10D","P10D","meteredTime",False),
        "fof_extra_decls": ("fof(dur_d0, axiom, dur(d0)).\n"
                            "fof(dur_p10, axiom, dur(p10)).\n"
                            "fof(ord_d0_p10, axiom, less(d0, p10)).\n"
                            "fof(distinct, axiom, $distinct(d0, p10)).\n"),
        "fof_conjecture": "![X]: ~(in_closed(X, p10, p10) & in_ropen(X, d0, p10))",
        "smt2_logic": "QF_LRA", "smt2_decls": "(declare-const x Real)",
        "smt2_asserts": "(assert (= x 10.0))\n(assert (>= x 0.0))\n(assert (< x 10.0))",
    },
]