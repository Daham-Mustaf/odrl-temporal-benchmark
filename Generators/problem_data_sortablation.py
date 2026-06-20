"""
problem_data_sortablation.py -- Sort-ambiguity discriminator: ODRL869-870.
The paper's core motivation made into an ablation. An offer constrains dateTime (an instant)
and a request constrains elapsedTime (a duration); the two operands live in DIFFERENT totally
ordered domains, so they cannot conflict. The ONLY difference between the two problems is whether
the instant and the duration are treated as comparable:
  869 (naive, unsorted): a single cross-sort order fact less(dur30, inst334) collapses both onto
      one axis, so the offer's lower instant bound and the request's upper duration bound become
      a single unsatisfiable window -> a SPURIOUS Conflict.
  870 (sort-stratified): no cross-sort fact, instant and duration stay incomparable, both
      constraints are independently satisfiable -> the correct verdict, no conflict (Compatible).
The pair shows that comparing across sorts is exactly what manufactures the false conflict, and
that the sort discipline removes it. Both are Ord/FOF, so all four reasoners decide them. SMT
mirrors it: one shared Int variable (unsat) vs two independent Int variables (sat).
"""
INST334 = 334   # dateTime 2026-12-01, day-of-year (2026-01-01 = 0)
DUR30 = 30      # duration P30D
PFX = "@prefix odrl: <http://www.w3.org/ns/odrl/2/> .\n@prefix xsd:  <http://www.w3.org/2001/XMLSchema#> .\n@prefix drk:  <http://w3id.org/drk/ontology/> .\n"
TTL = (PFX +
  "# offer constrains an instant (dateTime); request constrains a duration (elapsedTime).\n"
  "# Different sorts -> no interaction. A naive single-axis reading manufactures a conflict.\n"
  "drk:offer a odrl:Set ;\n  odrl:permission [ odrl:action odrl:use ;\n"
  '    odrl:constraint [ odrl:leftOperand odrl:dateTime ; odrl:operator odrl:gteq ; odrl:rightOperand "2026-12-01T00:00:00"^^xsd:dateTime ] ] .\n'
  "drk:request a odrl:Set ;\n  odrl:permission [ odrl:action odrl:use ;\n"
  '    odrl:constraint [ odrl:leftOperand odrl:elapsedTime ; odrl:operator odrl:lteq ; odrl:rightOperand "P30D"^^xsd:duration ] ] .\n')

def _P(pid, name, verdict, descr, extra, conj, smt_decls, smt_asserts, status_smt):
    return {
        "id": pid, "subdir": "SortAblation", "name": name, "relation": "sort-ablation", "verdict": verdict,
        "status_fof": "Theorem", "status_smt": status_smt, "difficulty": "Easy",
        "includes": ["ORD000-0.ax"], "tptp_lang": "fof", "needs_density": False,
        "description": descr, "ttl": TTL,
        "fof_extra_decls": extra, "fof_conjecture": conj,
        "smt2_logic": "QF_LIA", "smt2_decls": smt_decls, "smt2_asserts": smt_asserts,
    }

PROBLEMS = [
    _P("ODRL869", "naive unsorted reading collapses instant and duration -> spurious Conflict", "Conflict",
       ("WITHOUT sort stratification the instant 2026-12-01 (day 334) and the duration P30D (30) are placed on\n"
        "one axis via less(dur30, inst334); the offer's dateTime gteq day334 and the request's elapsedTime lteq\n"
        "30 then require a single point with 334 <= X <= 30, which is impossible. The naive engine reports a\n"
        "Conflict that is not real: the operands never shared a domain to begin with."),
       "fof(cross_sort, axiom, less(dur30, inst334)).\nfof(distinct, axiom, $distinct(dur30, inst334)).\n",
       "![X] : ~( leq(inst334, X) & leq(X, dur30) )",
       "(declare-const x Int)", "(assert (>= x 334))\n(assert (<= x 30))", "unsat"),
    _P("ODRL870", "sort-stratified reading keeps them incomparable -> no Conflict (Compatible)", "Compatible",
       ("WITH sort stratification the instant and the duration are in separate ordered domains (no cross-sort\n"
        "order fact), so the offer's dateTime constraint and the request's elapsedTime constraint are each\n"
        "satisfiable on their own axis (witnessed by inst334 and dur30 respectively) and never interact. The\n"
        "correct verdict is no conflict. This is the same policy pair as ODRL869; only the sort discipline differs."),
       "fof(distinct, axiom, $distinct(dur30, inst334)).\n",
       "leq(inst334, inst334) & leq(dur30, dur30)",
       "(declare-const xi Int)\n(declare-const xd Int)", "(assert (>= xi 334))\n(assert (<= xd 30))", "sat"),
]