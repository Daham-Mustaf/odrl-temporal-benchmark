(*  ODRL_PolicyVerdict.thy
    def:operand-verdict, def:product-verdict, lem:conflict-propagation,
    prop:monotone, def:completion, thm:unknown-sound
*)
theory ODRL_PolicyVerdict
  imports ODRL_Verdict ODRL_Intervals
begin

type_synonym 'a policy = "operand \<rightharpoonup> 'a ivl"   \<comment> \<open>None = operand unconstrained\<close>

definition all_operands :: "operand list" where
  "all_operands = [dateTime, delayPeriod, elapsedTime, meteredTime, timeInterval]"

lemma all_operands [simp]: "\<ell> \<in> set all_operands"
  by (cases \<ell>) (simp_all add: all_operands_def)

definition operand_verdict :: "'a::linorder policy \<Rightarrow> 'a policy \<Rightarrow> operand \<Rightarrow> verdict" where
  "operand_verdict P Q \<ell> =
     (case (P \<ell>, Q \<ell>) of
        (Some I, Some J) \<Rightarrow> (if set_of I \<inter> set_of J = {} then Conflict else Compatible)
      | (Some _, None)   \<Rightarrow> Unknown
      | (None,   Some _) \<Rightarrow> Unknown
      | (None,   None)   \<Rightarrow> Compatible)"

definition policy_verdict :: "'a::linorder policy \<Rightarrow> 'a policy \<Rightarrow> verdict" where
  "policy_verdict P Q = foldr (\<lambda>\<ell> a. min (operand_verdict P Q \<ell>) a) all_operands Compatible"

lemma policy_verdict_eq_Min:
  "policy_verdict P Q = fold min (map (operand_verdict P Q) all_operands) Compatible"
  \<comment> \<open>[routine] foldr/min vs fold/min agree on a commutative-idempotent monoid (min, Compatible top).\<close>
  sorry

text \<open>def:product-verdict consequence: one conflicting operand makes the policy verdict Conflict.\<close>

lemma conflict_dominates:
  "(\<exists>\<ell>. operand_verdict P Q \<ell> = Conflict) \<Longrightarrow> policy_verdict P Q = Conflict"
  \<comment> \<open>[routine] induction on all_operands; min Conflict _ = Conflict.\<close>
  sorry  \<comment> \<open>TODO: induction on all_operands; min Conflict _ = Conflict\<close>

text \<open>prop:monotone via lem:conflict-propagation, operand level then lifted.\<close>

lemma operand_monotone:
  assumes "P \<ell> = Some I" "P' \<ell> = Some I'" "Q \<ell> = Some J" "set_of I' \<subseteq> set_of I"
    and   "\<And>m. m \<noteq> \<ell> \<Longrightarrow> P' m = P m"
  shows   "operand_verdict P' Q \<ell> \<le> operand_verdict P Q \<ell>"
  using assms conflict_propagation
  by (auto simp: operand_verdict_def less_eq_verdict_def)

proposition monotone:
  assumes "\<And>m. operand_verdict P' Q m \<le> operand_verdict P Q m"
  shows   "policy_verdict P' Q \<le> policy_verdict P Q"
  \<comment> \<open>[routine] min is monotone in each argument; fold over the fixed list.\<close>
  sorry  \<comment> \<open>TODO: min monotone in each arg; fold over fixed list\<close>

text \<open>def:completion and thm:unknown-sound.\<close>

definition completes :: "'a policy \<Rightarrow> 'a policy \<Rightarrow> bool" where
  "completes Phat P \<longleftrightarrow> (\<forall>\<ell> I. P \<ell> = Some I \<longrightarrow> Phat \<ell> = Some I)
                     \<and> (\<forall>\<ell>. P \<ell> = None \<longrightarrow> (\<exists>I. Phat \<ell> = Some I))"

theorem unknown_characterisation:
  "policy_verdict P Q = Unknown
     \<longleftrightarrow> (\<forall>\<ell>. operand_verdict P Q \<ell> \<noteq> Conflict)
       \<and> (\<exists>\<ell>. operand_verdict P Q \<ell> = Unknown)"
  \<comment> \<open>[routine] policy_verdict = Min over a finite enumerated list; Min = Unknown iff
       no Conflict present and some Unknown present (Compatible is the top/identity).
       Use policy_verdict_eq_Min and the linorder facts on verdict.\<close>
  sorry

theorem unknown_sound_compatible:
  assumes "policy_verdict P Q = Unknown"
  shows   "\<exists>Phat Qhat. completes Phat P \<and> completes Qhat Q
                      \<and> policy_verdict Phat Qhat = Compatible"
  \<comment> \<open>[main, ~1-2 days]. Construct: for every operand a policy leaves unconstrained,
       add an Eq value lying in the other side's interval there (or any value where
       neither constrains it). Both-constrained axes were non-Conflict by assumption,
       so every operand verdict becomes Compatible.\<close>
  sorry

theorem unknown_sound_conflict:
  assumes "policy_verdict P Q = Unknown"
    and   "\<exists>\<ell> Cj. (P \<ell> = Some Cj \<and> Q \<ell> = None \<or> P \<ell> = None \<and> Q \<ell> = Some Cj)
                  \<and> set_of Cj \<noteq> UNIV"
  shows   "\<exists>Phat Qhat. completes Phat P \<and> completes Qhat Q
                      \<and> policy_verdict Phat Qhat = Conflict"
  \<comment> \<open>[main, ~1 day]. Pick \<ell> constrained by exactly one side with proper interval Cj;
       choose v outside set_of Cj; add (\<ell>,Eq,v) to the other side. Then that operand
       is Conflict (criterion), so the policy verdict is Conflict (conflict_dominates).
       Complete remaining unconstrained operands as in the compatible case.\<close>
  sorry

end
