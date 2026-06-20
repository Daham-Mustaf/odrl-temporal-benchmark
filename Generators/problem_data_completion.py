"""
problem_data_completion.py  -- Completion: ODRL856-858 (Ord/FOF, verdict algebra).
Completing an Unknown (Thm. unknown-sound). An Unknown operand verdict means the two
policies do not jointly pin that operand (one side silent). Adding the missing constraint
COMPLETES it: the per-operand verdict resolves to compatible or conflict, and the policy
verdict becomes definite. Soundness: completing never overturns an already-definite verdict
(a Conflict stays Conflict). Builds directly on the Unknown category (849-851): 856 completes
849's silent delayPeriod compatibly (Unknown -> Compatible); 857 completes it incompatibly
(Unknown -> Conflict); 858 completes 850's silent elapsedTime compatibly yet the dateTime
conflict stands (Conflict stable). Same machinery as Unknown: policy_verdict Kleene min,
SMT models verdicts as Int conflict=0 < unknown=1 < compatible=2, min = (ite (<= v1 v2) v1 v2).
"""
INC = ["ORD000-0.ax", "DENOT000-0.ax"]
VNUM = {"conflict": 0, "unknown": 1, "compatible": 2}

def _P(pid, name, verdict, descr, v1, v2, expected, ttl):
    return {
        "id": pid, "subdir": "Completion", "name": name, "relation": "verdict", "verdict": verdict,
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
def two(name, a_op, a_lo, a_val, b_op, b_lo, b_val):  # one policy, odrl:and of two atoms
    def atom(op, lo, val):
        dt = "xsd:dateTime" if lo == "dateTime" else "xsd:duration"
        return f'        [ odrl:leftOperand odrl:{lo} ; odrl:operator odrl:{op} ; odrl:rightOperand "{val}"^^{dt} ]\n'
    return (f"drk:{name} a odrl:Set ;\n  odrl:permission [\n    odrl:action odrl:use ;\n    odrl:constraint [\n      odrl:and (\n"
            + atom(a_op, a_lo, a_val) + atom(b_op, b_lo, b_val) + "      )\n    ]\n  ] .\n")

TTL856 = (P +
  "# offer constrains elapsedTime AND delayPeriod\n" +
  two("policyA", "lteq", "elapsedTime", "P10D", "gteq", "delayPeriod", "P1D") +
  "# request COMPLETES delayPeriod (was silent in the Unknown case); both operands now overlap\n" +
  two("policyB", "lteq", "elapsedTime", "P5D", "gteq", "delayPeriod", "P2D"))
TTL857 = (P +
  "# offer constrains elapsedTime AND delayPeriod (lower bound P5D)\n" +
  two("policyA", "lteq", "elapsedTime", "P10D", "gteq", "delayPeriod", "P5D") +
  "# request COMPLETES delayPeriod with eq P1D, which is below the offer's P5D floor -> disjoint\n" +
  two("policyB", "lteq", "elapsedTime", "P5D", "eq", "delayPeriod", "P1D"))
TTL858 = (P +
  "# offer: dateTime fixed AND elapsedTime capped\n" +
  two("policyA", "eq", "dateTime", "2026-08-01T00:00:00", "lteq", "elapsedTime", "P10D") +
  "# request: dateTime disjoint (Conflict) AND elapsedTime COMPLETED compatibly -- the conflict still stands\n" +
  two("policyB", "eq", "dateTime", "2027-01-01T00:00:00", "lteq", "elapsedTime", "P5D"))

PROBLEMS = [
    _P("ODRL856", "complete a silent operand compatibly: Unknown -> Compatible", "Compatible",
       ("Completes ODRL849: the request now constrains delayPeriod (gteq P2D), overlapping the offer's\n"
        "gteq P1D, so that operand resolves to compatible. With elapsedTime also compatible,\n"
        "policy_verdict(compatible, compatible) = compatible. The Unknown is resolved upward."),
       "compatible", "compatible", "compatible", TTL856),
    _P("ODRL857", "complete a silent operand incompatibly: Unknown -> Conflict", "Conflict",
       ("Completes ODRL849 the other way: the request pins delayPeriod eq P1D, below the offer's gteq P5D\n"
        "floor, so that operand resolves to conflict. policy_verdict(compatible, conflict) = conflict.\n"
        "The same Unknown operand can complete to either verdict; the added constraint decides."),
       "compatible", "conflict", "conflict", TTL857),
    _P("ODRL858", "completing another operand does not rescue a conflict (soundness)", "Conflict",
       ("Soundness (Thm. unknown-sound): ODRL850 had dateTime in conflict and elapsedTime silent (Unknown\n"
        "overall = Conflict). Completing elapsedTime compatibly leaves the dateTime conflict untouched:\n"
        "policy_verdict(conflict, compatible) = conflict. A definite Conflict is stable under completion."),
       "conflict", "compatible", "conflict", TTL858),
]