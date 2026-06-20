"""
problem_data_capstone.py  -- BSB-BnF capstone: ODRL825-826 (the paper's running example).
A full multi-operand policy-conflict check: do integer values exist for all
operands satisfying ALL constraints of both policies simultaneously?
Self-contained TFF/$int (inline, includes=[]), mirroring the SMT side.
  Conflict   -> ![DT,EL,DL,K,M:$int]: ~(constraints)   (Theorem; Vampire refutes)
  Compatible -> ?[DT,EL,DL,K,M:$int]:  (constraints)    (Theorem; integer witness)
Day counts (2026-01-01 = day 0): t_2026-12-31 = 364, t_2027-06-01 = 516, t_2026-05-31 = 150.
"""
# BSB offer (shared): dt<364, el<=30, dl>=1, dt on the P30D@day0 schedule; durations >= 0
BSB_TFF = ("$greatereq(EL,0) & $greatereq(DL,0) & $less(DT,364) & $lesseq(EL,30) & "
           "$greatereq(DL,1) & DT = $product(30,K) & $greatereq(K,0)")
BSB_SMT = ("(assert (>= el 0))\n(assert (>= dl 0))\n(assert (< dt 364))\n(assert (<= el 30))\n"
           "(assert (>= dl 1))\n(assert (= dt (* 30 k)))\n(assert (>= k 0))")
DECLS = ("(declare-const dt Int)\n(declare-const el Int)\n(declare-const dl Int)\n"
         "(declare-const k Int)\n(declare-const m Int)")

def _ttl(bnf_dt_iso, bnf_period, bnf_anchor_iso, bnf_el):
    return f"""\
@prefix odrl: <http://www.w3.org/ns/odrl/2/> .
@prefix xsd:  <http://www.w3.org/2001/XMLSchema#> .
@prefix drk:  <http://w3id.org/drk/ontology/> .
# BSB offer
drk:policyBSB a odrl:Set ;
  odrl:permission [ odrl:action odrl:use ; odrl:constraint [ odrl:and (
    [ odrl:leftOperand odrl:dateTime ;     odrl:operator odrl:lt   ; odrl:rightOperand "2026-12-31T00:00:00"^^xsd:dateTime ]
    [ odrl:leftOperand odrl:elapsedTime ;  odrl:operator odrl:lteq ; odrl:rightOperand "P30D"^^xsd:duration ]
    [ odrl:leftOperand odrl:delayPeriod ;  odrl:operator odrl:gteq ; odrl:rightOperand "P1D"^^xsd:duration ]
    [ odrl:leftOperand odrl:timeInterval ; odrl:operator odrl:eq   ; odrl:rightOperand "P30D"^^xsd:duration ; drk:anchor "2026-01-01"^^xsd:date ]
  ) ] ] .
# BnF request
drk:policyBnF a odrl:Set ;
  odrl:permission [ odrl:action odrl:use ; odrl:constraint [ odrl:and (
    [ odrl:leftOperand odrl:dateTime ;     odrl:operator odrl:eq   ; odrl:rightOperand "{bnf_dt_iso}"^^xsd:dateTime ]
    [ odrl:leftOperand odrl:elapsedTime ;  odrl:operator odrl:lteq ; odrl:rightOperand "{bnf_el}"^^xsd:duration ]
    [ odrl:leftOperand odrl:timeInterval ; odrl:operator odrl:eq   ; odrl:rightOperand "{bnf_period}"^^xsd:duration ; drk:anchor "{bnf_anchor_iso}"^^xsd:date ]
  ) ] ] ."""

PROBLEMS = [
    {   # the running example: Conflict (dateTime layer AND periodic layer both fail)
        "id": "ODRL825", "subdir": "Capstone",
        "name": "BSB-BnF running example -> Conflict",
        "relation": "conflict", "verdict": "Conflict",
        "status_fof": "Theorem", "status_smt": "unsat", "difficulty": "Medium",
        "includes": [], "tptp_lang": "tff", "needs_density": False,
        "description": (
            "BSB {dateTime lt 2026-12-31, elapsedTime lteq P30D, delayPeriod gteq P1D,\n"
            "timeInterval eq P30D @2026-01-01} vs BnF {dateTime eq 2027-06-01 (day 516),\n"
            "elapsedTime lteq P10D, timeInterval eq P45D @day 516}. No values satisfy\n"
            "both: the dateTime layer needs dt<364 and dt=516, and independently the\n"
            "periodic layer needs 15 | 516. Conflict (Vampire closes it via dt<364 & dt=516)."),
        "ttl": _ttl("2027-06-01T00:00:00", "P45D", "2027-06-01", "P10D"),
        "fof_extra_decls": "",
        "fof_conjecture": ("![DT:$int,EL:$int,DL:$int,K:$int,M:$int]: ~(" + BSB_TFF +
                           " & DT = 516 & $lesseq(EL,10) & "
                           "DT = $sum(516,$product(45,M)) & $greatereq(M,0))"),
        "smt2_logic": "QF_LIA", "smt2_decls": DECLS,
        "smt2_asserts": (BSB_SMT + "\n(assert (= dt 516))\n(assert (<= el 10))\n"
                         "(assert (= dt (+ 516 (* 45 m))))\n(assert (>= m 0))"),
    },
    {   # compatible variant: BnF access on 2026-05-31 (day 150, on BSB's schedule, in window)
        "id": "ODRL826", "subdir": "Capstone",
        "name": "BSB-BnF compatible variant -> Compatible",
        "relation": "conflict", "verdict": "Compatible",
        "status_fof": "Theorem", "status_smt": "sat", "difficulty": "Medium",
        "includes": [], "tptp_lang": "tff", "needs_density": False,
        "description": (
            "Same BSB offer, but BnF requests {dateTime eq 2026-05-31 (day 150),\n"
            "elapsedTime lteq P20D, timeInterval eq P30D @2026-01-01}. Day 150 is in\n"
            "BSB's window (<364) and on the shared P30D schedule (150 = 30*5), and the\n"
            "elapsed bounds agree. Values exist (dt=150, k=m=5). Compatible."),
        "ttl": _ttl("2026-05-31T00:00:00", "P30D", "2026-01-01", "P20D"),
        "fof_extra_decls": "",
        "fof_conjecture": ("?[DT:$int,EL:$int,DL:$int,K:$int,M:$int]: (" + BSB_TFF +
                           " & DT = 150 & $lesseq(EL,20) & "
                           "DT = $product(30,M) & $greatereq(M,0))"),
        "smt2_logic": "QF_LIA", "smt2_decls": DECLS,
        "smt2_asserts": (BSB_SMT + "\n(assert (= dt 150))\n(assert (<= el 20))\n"
                         "(assert (= dt (* 30 m)))\n(assert (>= m 0))"),
    },
]