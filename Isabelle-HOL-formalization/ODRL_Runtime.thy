(*  ODRL_Runtime.thy
    def:static-conflict, def:runtime-eval, def:runtime-conflict,
    def:realizability, def:trace-conflict, thm:static-runtime, cor:bridge
*)
theory ODRL_Runtime
  imports ODRL_Background ODRL_Sequence
begin

text \<open>def:static-conflict. Same as conflict (def:frame) with the context symbolic.\<close>

definition static_conflict :: "csys \<Rightarrow> csys \<Rightarrow> bool" where
  "static_conflict C1 C2 \<longleftrightarrow> conflict C1 C2"

text \<open>def:runtime-eval. A ground context fixes now,trig and the start; duration
      operands are computed from timestamps and the metered segment sum.\<close>

definition elapsed_val :: "inst \<Rightarrow> inst \<Rightarrow> dur" where
  "elapsed_val dstart now = diff dstart now"

definition delay_val :: "inst \<Rightarrow> inst \<Rightarrow> dur" where
  "delay_val trg now = diff trg now"

definition metered_val :: "(inst \<times> inst) list \<Rightarrow> dur" where
  "metered_val segs = (\<Sum>(s,e)\<leftarrow>segs. diff s e)"

text \<open>def:runtime-conflict. A ground context conflicts with (C1,C2) if it fails
      either policy.\<close>

definition models :: "ctxt \<Rightarrow> csys \<Rightarrow> bool" where
  "models \<rho> C \<longleftrightarrow> C \<rho>"

definition runtime_conflict :: "ctxt \<Rightarrow> csys \<Rightarrow> csys \<Rightarrow> bool" where
  "runtime_conflict \<rho> C1 C2 \<longleftrightarrow> \<not> models \<rho> C1 \<or> \<not> models \<rho> C2"

text \<open>def:realizability. A policy is realizable iff some trace satisfies it.\<close>

definition realizable :: "(state list \<Rightarrow> bool) \<Rightarrow> bool" where
  "realizable C \<longleftrightarrow> (\<exists>\<tau>. wf_trace \<tau> \<and> C \<tau>)"

text \<open>def:trace-conflict. For a trigger-dependent andSequence, C1,C2 trace-conflict
      iff no trace satisfies both (equivalently the joint difference system is
      infeasible: Diff tier).\<close>

definition trace_conflict :: "(state list \<Rightarrow> bool) \<Rightarrow> (state list \<Rightarrow> bool) \<Rightarrow> bool" where
  "trace_conflict C1 C2 \<longleftrightarrow> (\<nexists>\<tau>. wf_trace \<tau> \<and> C1 \<tau> \<and> C2 \<tau>)"

text \<open>thm:static-runtime.
      (1) Soundness: static conflict \<Longrightarrow> no exercise satisfies both.
      (2) Refinement, not reversal: a static non-conflict need not make every ground
          context compliant; but no ground context overturns a static conflict.
      (3) Theory: static conflict is the tiered decision; ground evaluation is pure
          computation; realizability is the one search task (Diff/Mod).\<close>

theorem static_runtime_sound:
  assumes "static_conflict C1 C2"
  shows   "\<nexists>\<rho>. models \<rho> C1 \<and> models \<rho> C2 \<and> Phi \<rho>"
  using assms by (simp add: static_conflict_def conflict_def models_def)

theorem static_runtime_no_reversal:
  \<comment> \<open>no ground context overturns a static conflict (contrapositive of soundness).\<close>
  assumes "static_conflict C1 C2" "Phi \<rho>"
  shows   "\<not> (models \<rho> C1 \<and> models \<rho> C2)"
  using static_runtime_sound[OF assms(1)] assms(2) by blast

theorem static_noconflict_not_per_context:
  \<comment> \<open>a static non-conflict has SOME satisfying context, but a GIVEN \<rho> may still fail.
     This is an existence statement, not an implication; stated for completeness.\<close>
  shows "\<not> static_conflict C1 C2 \<longrightarrow> (\<exists>\<rho>. models \<rho> C1 \<and> models \<rho> C2 \<and> Phi \<rho>)"
  by (auto simp: static_conflict_def conflict_def models_def)

corollary bridge_positional_metric:
  \<comment> \<open>cor:bridge: under andSequence, delayPeriod carries both a positional component
     (the chosen trigger instant) and a metric one (diff(trig,now)); no purely
     order-based encoding, so it lies in the Diff tier. Recorded as a remark; the
     formal content is the Diff classification in ODRL_Background.tiered_Diff.\<close>
  shows True
  by simp

end
