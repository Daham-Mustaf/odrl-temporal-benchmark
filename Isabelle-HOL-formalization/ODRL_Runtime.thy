(*  ODRL_Runtime.thy
    def:static-conflict, def:runtime-eval, def:runtime-conflict,
    def:realizability, def:trace-conflict, thm:static-runtime, cor:bridge
*)
theory ODRL_Runtime
  imports ODRL_Background ODRL_Sequence
begin

text ‹def:static-conflict. Same as conflict (def:frame) with the context symbolic.›

definition static_conflict :: "csys ⇒ csys ⇒ bool" where
  "static_conflict C1 C2 ⟷ conflict C1 C2"

text ‹def:runtime-eval. A ground context fixes now,trig and the start; duration
      operands are computed from timestamps and the metered segment sum.›

definition elapsed_val :: "inst ⇒ inst ⇒ dur" where
  "elapsed_val dstart now = diff dstart now"

definition delay_val :: "inst ⇒ inst ⇒ dur" where
  "delay_val trg now = diff trg now"

definition metered_val :: "(inst × inst) list ⇒ dur" where
  "metered_val segs = (∑(s,e)←segs. diff s e)"

text ‹def:runtime-conflict. A ground context conflicts with (C1,C2) if it fails
      either policy.›

definition models :: "ctxt ⇒ csys ⇒ bool" where
  "models ρ C ⟷ C ρ"

definition runtime_conflict :: "ctxt ⇒ csys ⇒ csys ⇒ bool" where
  "runtime_conflict ρ C1 C2 ⟷ ¬ models ρ C1 ∨ ¬ models ρ C2"

text ‹def:realizability. A policy is realizable iff some trace satisfies it.›

definition realizable :: "(state list ⇒ bool) ⇒ bool" where
  "realizable C ⟷ (∃τ. wf_trace τ ∧ C τ)"

text ‹def:trace-conflict. For a trigger-dependent andSequence, C1,C2 trace-conflict
      iff no trace satisfies both (equivalently the joint difference system is
      infeasible: Diff tier).›

definition trace_conflict :: "(state list ⇒ bool) ⇒ (state list ⇒ bool) ⇒ bool" where
  "trace_conflict C1 C2 ⟷ (∄τ. wf_trace τ ∧ C1 τ ∧ C2 τ)"

text ‹thm:static-runtime.
      (1) Soundness: static conflict ⟹ no exercise satisfies both.
      (2) Refinement, not reversal: a static non-conflict need not make every ground
          context compliant; but no ground context overturns a static conflict.
      (3) Theory: static conflict is the tiered decision; ground evaluation is pure
          computation; realizability is the one search task (Diff/Mod).›

theorem static_runtime_sound:
  assumes "static_conflict C1 C2"
  shows   "∄ρ. models ρ C1 ∧ models ρ C2 ∧ Phi ρ"
  using assms by (simp add: static_conflict_def conflict_def models_def)

theorem static_runtime_no_reversal:
  ― ‹no ground context overturns a static conflict (contrapositive of soundness).›
  assumes "static_conflict C1 C2" "Phi ρ"
  shows   "¬ (models ρ C1 ∧ models ρ C2)"
  using static_runtime_sound[OF assms(1)] assms(2) by blast

theorem static_noconflict_not_per_context:
  ― ‹a static non-conflict has SOME satisfying context, but a GIVEN ρ may still fail.
     This is an existence statement, not an implication; stated for completeness.›
  shows "¬ static_conflict C1 C2 ⟶ (∃ρ. models ρ C1 ∧ models ρ C2 ∧ Phi ρ)"
  by (auto simp: static_conflict_def conflict_def models_def)

corollary bridge_positional_metric:
  ― ‹cor:bridge: under andSequence, delayPeriod carries both a positional component
     (the chosen trigger instant) and a metric one (diff(trig,now)); no purely
     order-based encoding, so it lies in the Diff tier. Recorded as a remark; the
     formal content is the Diff classification in ODRL_Background.tiered_Diff.›
  shows True
  by simp

end
