"""
problem_data_cross.py  -- CrossOperand: ODRL821-824 (Mod tier).
Conflicts/compatibilities that depend on the cross-operand invariant Phi
(meteredTime <= elapsedTime, durations >= 0). Self-contained TFF/$int that
inlines Phi over Int variables (includes=[]), mirroring the SMT side, so the
witness/refutation lives in the interpreted integer domain.
  Conflict   -> ![ME,EL:$int]: ~(Phi & constraints)   (Theorem; Vampire refutes)
  Compatible -> ?[ME,EL:$int]:  (Phi & constraints)    (Theorem; integer witness)
Without Phi the pairs 821/823 are jointly satisfiable; Phi creates the conflict.
"""
PHI_TFF = "$greatereq(ME,0) & $greatereq(EL,0) & $lesseq(ME,EL)"
DECLS   = "(declare-const me Int)\n(declare-const el Int)"
PHI_SMT = "(assert (>= me 0))\n(assert (>= el 0))\n(assert (<= me el))"

def _ttl(opA, vA, opB, vB):
    return f"""\
@prefix odrl: <http://www.w3.org/ns/odrl/2/> .
@prefix xsd:  <http://www.w3.org/2001/XMLSchema#> .
@prefix drk:  <http://w3id.org/drk/ontology/> .
drk:policyA a odrl:Set ;
  odrl:permission [ odrl:action odrl:use ;
    odrl:constraint [ odrl:leftOperand odrl:meteredTime ;
      odrl:operator odrl:{opA} ; odrl:rightOperand "{vA}"^^xsd:duration ] ] .
drk:policyB a odrl:Set ;
  odrl:permission [ odrl:action odrl:use ;
    odrl:constraint [ odrl:leftOperand odrl:elapsedTime ;
      odrl:operator odrl:{opB} ; odrl:rightOperand "{vB}"^^xsd:duration ] ] ."""

def _P(pid, name, verdict, smt_status, descr, ttl, cons_tff, cons_smt):
    if verdict == "Compatible":
        conj = f"?[ME:$int,EL:$int]: ({PHI_TFF} & {cons_tff})"
    else:
        conj = f"![ME:$int,EL:$int]: ~({PHI_TFF} & {cons_tff})"
    return {
        "id": pid, "subdir": "CrossOperand", "name": name,
        "relation": "conflict", "verdict": verdict,
        "status_fof": "Theorem", "status_smt": smt_status, "difficulty": "Medium",
        "includes": [], "tptp_lang": "tff", "needs_density": False,
        "description": descr, "ttl": ttl, "fof_extra_decls": "",
        "fof_conjecture": conj,
        "smt2_logic": "QF_LIA", "smt2_decls": DECLS,
        "smt2_asserts": PHI_SMT + "\n" + cons_smt,
    }

PROBLEMS = [
    _P("ODRL821", "meteredTime eq P20D & elapsedTime lteq P10D -> Conflict (via Phi)",
       "Conflict", "unsat",
       ("meteredTime eq P20D (me=20) & elapsedTime lteq P10D (el<=10).\n"
        "Phi forces me <= el, so 20 <= el <= 10 is impossible. Conflict.\n"
        "Without Phi the two would be jointly satisfiable (Compatible)."),
       _ttl("eq","P20D","lteq","P10D"),
       "ME = 20 & $lesseq(EL,10)",
       "(assert (= me 20))\n(assert (<= el 10))"),
    _P("ODRL822", "meteredTime eq P5D & elapsedTime lteq P10D -> Compatible",
       "Compatible", "sat",
       ("meteredTime eq P5D (me=5) & elapsedTime lteq P10D (el<=10).\n"
        "Phi (me <= el) holds with el in [5,10]. Compatible (witness me=5, el=10)."),
       _ttl("eq","P5D","lteq","P10D"),
       "ME = 5 & $lesseq(EL,10)",
       "(assert (= me 5))\n(assert (<= el 10))"),
    _P("ODRL823", "meteredTime eq P20D & elapsedTime eq P10D -> Conflict (via Phi)",
       "Conflict", "unsat",
       ("meteredTime eq P20D (me=20) & elapsedTime eq P10D (el=10).\n"
        "Phi forces me <= el, i.e. 20 <= 10. Conflict."),
       _ttl("eq","P20D","eq","P10D"),
       "ME = 20 & EL = 10",
       "(assert (= me 20))\n(assert (= el 10))"),
    _P("ODRL824", "meteredTime lteq P10D & elapsedTime eq P20D -> Compatible",
       "Compatible", "sat",
       ("meteredTime lteq P10D (me<=10) & elapsedTime eq P20D (el=20).\n"
        "Phi (me <= el = 20) holds for any me <= 10. Compatible."),
       _ttl("lteq","P10D","eq","P20D"),
       "$lesseq(ME,10) & EL = 20",
       "(assert (<= me 10))\n(assert (= el 20))"),
]