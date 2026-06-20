"""
problem_data_realizability.py -- Realizability / well-formedness: ODRL865-868.
The ONE single-policy notion (Def. realizability): a policy is unrealizable when its OWN
constraints are jointly unsatisfiable, independent of any counter-party. Every other category
compares an offer against a request; this asks whether a single policy can be satisfied at all.
Two Ord problems (a single party's dateTime window that is empty vs proper) and two Diff/STN
problems (the paper's flagship case: an andSequence whose required gaps exceed its own
elapsedTime cap, vs one that fits). Realizable -> SAT (.smt2 sat); Unrealizable -> UNSAT
(.smt2 unsat). The Ord pair is FOF (all four reasoners); the STN pair is TFF/$int and follows
the Sequence gradient (z3/cvc5 decide, Vampire and E time out on the Presburger reasoning).
"""

INST = {"mar1": 59, "jun1": 151}  # day-of-year, 2026-01-01 = 0
ISO = {"mar1": "2026-03-01", "jun1": "2026-06-01"}
PFX = "@prefix odrl: <http://www.w3.org/ns/odrl/2/> .\n@prefix xsd:  <http://www.w3.org/2001/XMLSchema#> .\n@prefix drk:  <http://w3id.org/drk/ontology/> .\n"

def order_block(cs):
    cs = sorted(set(cs), key=lambda c: INST[c])
    L = [f"fof(ord_{cs[i]}_{cs[i+1]}, axiom, less({cs[i]}, {cs[i+1]}))." for i in range(len(cs) - 1)]
    L.append(f"fof(distinct, axiom, $distinct({', '.join(cs)})).")
    return "\n".join(L) + "\n"

def _ttl_window(lo, hi):  # single policy: dateTime gteq lo AND lt hi
    return (PFX + "# single policy: one party's own dateTime window\n"
            "drk:policy a odrl:Set ;\n  odrl:permission [\n    odrl:action odrl:use ;\n    odrl:constraint [\n      odrl:and (\n"
            f'        [ odrl:leftOperand odrl:dateTime ; odrl:operator odrl:gteq ; odrl:rightOperand "{ISO[lo]}T00:00:00"^^xsd:dateTime ]\n'
            f'        [ odrl:leftOperand odrl:dateTime ; odrl:operator odrl:lt ; odrl:rightOperand "{ISO[hi]}T00:00:00"^^xsd:dateTime ]\n'
            "      )\n    ]\n  ] .\n")

def _ttl_seq(cap):  # single policy: andSequence of two P5D gaps, capped by elapsedTime
    return (PFX + "# single policy: a two-step andSequence with a global elapsedTime cap\n"
            "drk:policy a odrl:Set ;\n  odrl:permission [\n    odrl:action odrl:use ;\n    odrl:constraint [\n      odrl:and (\n"
            "        [ odrl:andSequence (\n"
            '            [ odrl:leftOperand odrl:delayPeriod ; odrl:operator odrl:gteq ; odrl:rightOperand "P5D"^^xsd:duration ]\n'
            '            [ odrl:leftOperand odrl:delayPeriod ; odrl:operator odrl:gteq ; odrl:rightOperand "P5D"^^xsd:duration ]\n'
            "          ) ]\n"
            f'        [ odrl:leftOperand odrl:elapsedTime ; odrl:operator odrl:lteq ; odrl:rightOperand "{cap}"^^xsd:duration ]\n'
            "      )\n    ]\n  ] .\n")

def _ord(pid, name, verdict, descr, lo, hi, realizable):
    # window [gteq lo, lt hi]; realizable iff lo < hi
    if realizable:
        conj = f"leq({lo}, {lo}) & less({lo}, {hi})"            # witness = lower bound in [lo,hi)
        smt_a = f"(assert (and (<= {INST[lo]} x) (< x {INST[hi]})))"
        status_smt = "sat"
    else:
        conj = f"![X] : ~( leq({lo}, X) & less(X, {hi}) )"      # no point in [lo,hi) since lo > hi
        smt_a = f"(assert (and (<= {INST[lo]} x) (< x {INST[hi]})))"
        status_smt = "unsat"
    return {
        "id": pid, "subdir": "Realizability", "name": name, "relation": "realizability", "verdict": verdict,
        "status_fof": "Theorem", "status_smt": status_smt, "difficulty": "Easy",
        "includes": ["ORD000-0.ax"], "tptp_lang": "fof", "needs_density": False,
        "description": descr, "ttl": _ttl_window(lo, hi),
        "fof_extra_decls": order_block([lo, hi]), "fof_conjecture": conj,
        "smt2_logic": "QF_LIA", "smt2_decls": "(declare-const x Int)", "smt2_asserts": smt_a,
    }

def _seq(pid, name, verdict, descr, cap_days, realizable):
    # STN: p0=0, p1>=5, p2-p1>=5, p2<=cap ; feasible iff cap >= 10
    body = f"$greatereq(P1, 5) & $greatereq($difference(P2, P1), 5) & $lesseq(P2, {cap_days})"
    if realizable:
        conj = f"?[P1 : $int, P2 : $int] : ( {body} )"
        status_smt = "sat"
    else:
        conj = f"![P1 : $int, P2 : $int] : ~( {body} )"
        status_smt = "unsat"
    smt = (f"(declare-const p1 Int)\n(declare-const p2 Int)\n"
           f"(assert (>= p1 5))\n(assert (>= (- p2 p1) 5))\n(assert (<= p2 {cap_days}))")
    return {
        "id": pid, "subdir": "Realizability", "name": name, "relation": "realizability", "verdict": verdict,
        "status_fof": "Theorem", "status_smt": status_smt, "difficulty": "Medium",
        "includes": [], "tptp_lang": "tff", "needs_density": False,
        "description": descr, "ttl": _ttl_seq(f"P{cap_days}D"),
        "fof_extra_decls": "", "fof_conjecture": conj,
        "smt2_logic": "QF_LIA", "smt2_decls": "", "smt2_asserts": smt,
    }

PROBLEMS = [
    _ord("ODRL865", "single policy with an empty dateTime window -> Unrealizable", "Unrealizable",
         "One party's rule requires dateTime gteq 2026-06-01 and dateTime lt 2026-03-01; the lower bound is after the upper bound, so no instant satisfies the policy. Unrealizable.",
         "jun1", "mar1", False),
    _ord("ODRL866", "single policy with a proper dateTime window -> Realizable", "Realizable",
         "One party's rule requires dateTime gteq 2026-03-01 and dateTime lt 2026-06-01; the window is non-empty (the lower bound itself satisfies it), so the policy is satisfiable. Realizable.",
         "mar1", "jun1", True),
    _seq("ODRL867", "andSequence demands more delay than its own cap -> Unrealizable", "Unrealizable",
         ("One policy: an andSequence of two delayPeriod gteq P5D steps (>= 10 days of gaps) under a global\n"
          "elapsedTime lteq P8D cap. The sequence cannot complete within the cap (10 > 8), so the policy is\n"
          "internally unsatisfiable. STN: p1>=5, p2-p1>=5, p2<=8 is infeasible. Unrealizable."),
         8, False),
    _seq("ODRL868", "andSequence fits within its cap -> Realizable", "Realizable",
         ("Same policy with the cap relaxed to elapsedTime lteq P12D. The two P5D gaps fit (10 <= 12), so a\n"
          "valid schedule exists (e.g. p1=5, p2=10). STN: p1>=5, p2-p1>=5, p2<=12 is feasible. Realizable."),
         12, True),
]