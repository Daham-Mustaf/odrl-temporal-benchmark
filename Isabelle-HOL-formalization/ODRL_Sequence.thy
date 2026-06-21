(*  ODRL_Sequence.thy
    def:trace, def:andseq, lem:andseq-strict, prop:collapse (Sec. 4.3)
*)
theory ODRL_Sequence
  imports ODRL_Structures
begin

text ‹def:trace. A trace is a list of states with strictly increasing timestamps;
      each state induces a context with now = its timestamp.›

record state =
  ts :: inst

definition wf_trace :: "state list ⇒ bool" where
  "wf_trace τ ⟷ sorted_wrt (λa b. ts a < ts b) τ"

text ‹A constraint here is satisfied at a state given a trigger instant (the bound
      for trig). Only delayPeriod-style constraints read trig.›

type_synonym sat = "inst ⇒ state ⇒ bool"   ― ‹trig ⇒ state ⇒ holds›

text ‹def:andseq. Holds on τ iff there is a non-decreasing index tuple j1≤…≤jn with
      each C_k satisfied at state j_k under trigger = timestamp of the previous
      satisfaction (free for k=1).›

fun sat_seq :: "sat list ⇒ inst ⇒ state list ⇒ nat list ⇒ bool" where
  "sat_seq [] _ _ [] = True"
| "sat_seq (C#Cs) trg τ (j#js) =
     (j < length τ ∧ C trg (τ!j) ∧ sat_seq Cs (ts (τ!j)) τ js)"
| "sat_seq _ _ _ _ = False"

definition andSequence :: "sat list ⇒ inst ⇒ state list ⇒ bool" where
  "andSequence Cs trg0 τ ⟷
     (∃js. length js = length Cs ∧ sorted js ∧ (∀j∈set js. j < length τ)
           ∧ sat_seq Cs trg0 τ js)"

definition unresolvable :: "sat list ⇒ inst ⇒ state list ⇒ bool" where
  "unresolvable Cs trg0 τ ⟷ ¬ andSequence Cs trg0 τ"

text ‹lem:andseq-strict. A step forcing a positive delay forces strict index
      separation. Modeled: if at step k the satisfaction implies ts(state) > trig,
      then the chosen index strictly exceeds the previous one.›

definition forces_pos_delay :: "sat ⇒ bool" where
  "forces_pos_delay C ⟷ (∀trg s. C trg s ⟶ trg < ts s)"

lemma andseq_strict:
  assumes "wf_trace τ"
    and   "forces_pos_delay C"
    and   "C (ts (τ!jprev)) (τ!j)"
    and   "jprev < length τ" "j < length τ"
  shows   "jprev < j"
  ― ‹[routine] forces_pos_delay gives ts(τ!jprev) < ts(τ!j); strict-increasing
       timestamps (wf_trace) are injective and order-reflecting on indices.›
  using assms
  by (metis forces_pos_delay_def wf_trace_def linorder_neqE_nat not_less_iff_gr_or_eq
            sorted_wrt_nth_less nless_le)  ― ‹may need an index lemma; adjust if it fails›

text ‹prop:collapse. With no constraint reading trig, sequencing on a single-state
      trace coincides with conjunction at that state.›

definition reads_trig :: "sat ⇒ bool" where
  "reads_trig C ⟷ (∃t1 t2 s. C t1 s ≠ C t2 s)"

lemma collapse_to_and:
  assumes "∀C∈set Cs. ¬ reads_trig C"
  shows   "andSequence Cs trg0 [s] ⟷ (∀C∈set Cs. C trg0 s)"
  ― ‹[routine] on [s] the only non-decreasing tuple is the constant 0…0; with no
       trig dependence each C's value is fixed by the state, so the sequence holds
       iff every C holds at s.›
  sorry

end
