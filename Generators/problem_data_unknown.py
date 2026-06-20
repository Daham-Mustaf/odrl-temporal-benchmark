"""
problem_data_unknown.py  -- Unknown verdict: ODRL849-851 (Ord/FOF, verdict algebra).
The three-valued MIDDLE value. When both policies constrain an operand the per-operand
verdict is compatible/conflict; when only ONE side constrains it the verdict is unknown
(Def. per-operand). policy_verdict aggregates by Kleene min (conflict < unknown <
compatible). These prove the aggregation, exercising the DENOT000 policy_verdict
combinator and the `unknown` constant (otherwise unused). SMT models verdicts as Int
conflict=0 < unknown=1 < compatible=2 with min = (ite (<= v1 v2) v1 v2).
"""
INC = ["ORD000-0.ax", "DENOT000-0.ax"]
VNUM = {"conflict": 0, "unknown": 1, "compatible": 2}

def _P(pid, name, verdict, descr, v1, v2, expected, ttl):
    return {
        "id": pid, "subdir": "Unknown", "name": name, "relation": "verdict", "verdict": verdict,
        "status_fof": "Theorem", "status_smt": "unsat", "difficulty": "Easy",
        "includes": INC, "tptp_lang": "fof", "needs_density": False,
        "description": descr, "ttl": ttl, "fof_extra_decls": "",
        "fof_conjecture": f"policy_verdict({v1}, {v2}) = {expected}",
        "smt2_logic": "QF_LIA",
        "smt2_decls": "(declare-const v1 Int)\n(declare-const v2 Int)",
        "smt2_asserts": (f"(assert (= v1 {VNUM[v1]}))\n(assert (= v2 {VNUM[v2]}))\n"
                         f"(assert (not (= (ite (<= v1 v2) v1 v2) {VNUM[expected]})))"),
    }

P = "@prefix odrl: <http://www.w3.org/ns/odrl/2/> .\n@prefix xsd:  <http://www.w3.org/2001/XMLSchema#> .\n@prefix drk:  <http://w3id.org/drk/ontology/> .\n"
TTL849 = (P +
  "# offer constrains elapsedTime AND delayPeriod\n"
  "drk:policyA a odrl:Set ;\n  odrl:permission [\n    odrl:action odrl:use ;\n    odrl:constraint [\n      odrl:and (\n"
  '        [ odrl:leftOperand odrl:elapsedTime ; odrl:operator odrl:lteq ; odrl:rightOperand "P10D"^^xsd:duration ]\n'
  '        [ odrl:leftOperand odrl:delayPeriod ; odrl:operator odrl:gteq ; odrl:rightOperand "P1D"^^xsd:duration ]\n'
  "      )\n    ]\n  ] .\n"
  "# request constrains ONLY elapsedTime (silent on delayPeriod)\n"
  "drk:policyB a odrl:Set ;\n  odrl:permission [ odrl:action odrl:use ;\n"
  '    odrl:constraint [ odrl:leftOperand odrl:elapsedTime ; odrl:operator odrl:lteq ; odrl:rightOperand "P5D"^^xsd:duration ] ] .')
TTL850 = (P +
  "# offer constrains dateTime AND elapsedTime\n"
  "drk:policyA a odrl:Set ;\n  odrl:permission [\n    odrl:action odrl:use ;\n    odrl:constraint [\n      odrl:and (\n"
  '        [ odrl:leftOperand odrl:dateTime ; odrl:operator odrl:eq ; odrl:rightOperand "2026-08-01T00:00:00"^^xsd:dateTime ]\n'
  '        [ odrl:leftOperand odrl:elapsedTime ; odrl:operator odrl:lteq ; odrl:rightOperand "P10D"^^xsd:duration ]\n'
  "      )\n    ]\n  ] .\n"
  "# request constrains ONLY dateTime, disjoint from the offer (silent on elapsedTime)\n"
  "drk:policyB a odrl:Set ;\n  odrl:permission [ odrl:action odrl:use ;\n"
  '    odrl:constraint [ odrl:leftOperand odrl:dateTime ; odrl:operator odrl:eq ; odrl:rightOperand "2027-01-01T00:00:00"^^xsd:dateTime ] ] .')
TTL851 = (P +
  "# offer constrains ONLY elapsedTime (silent on delayPeriod)\n"
  "drk:policyA a odrl:Set ;\n  odrl:permission [ odrl:action odrl:use ;\n"
  '    odrl:constraint [ odrl:leftOperand odrl:elapsedTime ; odrl:operator odrl:lteq ; odrl:rightOperand "P10D"^^xsd:duration ] ] .\n'
  "# request constrains ONLY delayPeriod (silent on elapsedTime)\n"
  "drk:policyB a odrl:Set ;\n  odrl:permission [ odrl:action odrl:use ;\n"
  '    odrl:constraint [ odrl:leftOperand odrl:delayPeriod ; odrl:operator odrl:gteq ; odrl:rightOperand "P1D"^^xsd:duration ] ] .')

PROBLEMS = [
    _P("ODRL849", "compatible operand + silent operand -> Unknown", "Unknown",
       ("elapsedTime is constrained by both (offer lteq P10D, request lteq P5D; overlap -> compatible),\n"
        "but delayPeriod is constrained only by the offer (request silent -> unknown). Kleene min:\n"
        "policy_verdict(compatible, unknown) = unknown. The pair is underdetermined, not a conflict."),
       "compatible", "unknown", "unknown", TTL849),
    _P("ODRL850", "conflict operand dominates a silent operand -> Conflict", "Conflict",
       ("dateTime is constrained by both and disjoint (offer eq 2026-08-01, request eq 2027-01-01 ->\n"
        "conflict); elapsedTime only by the offer (-> unknown). Kleene min, conflict is bottom:\n"
        "policy_verdict(conflict, unknown) = conflict. A real conflict overrides the indeterminacy."),
       "conflict", "unknown", "conflict", TTL850),
    _P("ODRL851", "two silent operands -> Unknown", "Unknown",
       ("Each operand is constrained by only one side: elapsedTime only by the offer, delayPeriod only\n"
        "by the request. Both per-operand verdicts are unknown, so policy_verdict(unknown, unknown) =\n"
        "unknown. Nothing forces a conflict and nothing is jointly pinned."),
       "unknown", "unknown", "unknown", TTL851),
]