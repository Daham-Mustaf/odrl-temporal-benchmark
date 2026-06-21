(*  ODRL_PolicyVerdict.thy
    def:operand-verdict, def:product-verdict, lem:conflict-propagation,
    prop:monotone, def:completion, thm:unknown-sound
*)
theory ODRL_PolicyVerdict
  imports ODRL_Verdict ODRL_Intervals
begin

type_synonym 'a policy = "operand ⇀ 'a ivl"   ― ‹None = operand unconstrained›

definition all_operands :: "operand list" where
  "all_operands = [dateTime, delayPeriod, elapsedTime, meteredTime, timeInterval]"

lemma all_operands [simp]: "ℓ ∈ set all_operands"
  by (cases ℓ) (simp_all add: all_operands_def)

definition operand_verdict :: "'a::linorder policy ⇒ 'a policy ⇒ operand ⇒ verdict" where
  "operand_verdict P Q ℓ =
     (case (P ℓ, Q ℓ) of
        (Some I, Some J) ⇒ (if set_of I ∩ set_of J = {} then Conflict else Compatible)
      | (Some _, None)   ⇒ Unknown
      | (None,   Some _) ⇒ Unknown
      | (None,   None)   ⇒ Compatible)"

definition policy_verdict :: "'a::linorder policy ⇒ 'a policy ⇒ verdict" where
  "policy_verdict P Q = foldr (λℓ a. min (operand_verdict P Q ℓ) a) all_operands Compatible"

lemma policy_verdict_eq_Min:
  "policy_verdict P Q = fold min (map (operand_verdict P Q) all_operands) Compatible"
  ― ‹[routine] foldr/min vs fold/min agree on a commutative-idempotent monoid (min, Compatible top).›
  sorry

text ‹def:product-verdict consequence: one conflicting operand makes the policy verdict Conflict.›

lemma conflict_dominates:
  "(∃ℓ. operand_verdict P Q ℓ = Conflict) ⟹ policy_verdict P Q = Conflict"
  ― ‹[routine] induction on all_operands; min Conflict _ = Conflict.›
  by (auto simp: policy_verdict_def)
     (smt (verit) all_operands_def foldr.simps min_Conflict o_apply set_ConsD)

text ‹prop:monotone via lem:conflict-propagation, operand level then lifted.›

lemma operand_monotone:
  assumes "P ℓ = Some I" "P' ℓ = Some I'" "Q ℓ = Some J" "set_of I' ⊆ set_of I"
    and   "⋀m. m ≠ ℓ ⟹ P' m = P m"
  shows   "operand_verdict P' Q ℓ ≤ operand_verdict P Q ℓ"
  using assms conflict_propagation
  by (auto simp: operand_verdict_def less_eq_verdict_def)

proposition monotone:
  assumes "⋀m. operand_verdict P' Q m ≤ operand_verdict P Q m"
  shows   "policy_verdict P' Q ≤ policy_verdict P Q"
  ― ‹[routine] min is monotone in each argument; fold over the fixed list.›
  using assms by (induction "all_operands") (auto simp: policy_verdict_def intro: min.mono)

text ‹def:completion and thm:unknown-sound.›

definition completes :: "'a policy ⇒ 'a policy ⇒ bool" where
  "completes Phat P ⟷ (∀ℓ I. P ℓ = Some I ⟶ Phat ℓ = Some I)
                     ∧ (∀ℓ. P ℓ = None ⟶ (∃I. Phat ℓ = Some I))"

theorem unknown_characterisation:
  "policy_verdict P Q = Unknown
     ⟷ (∀ℓ. operand_verdict P Q ℓ ≠ Conflict)
       ∧ (∃ℓ. operand_verdict P Q ℓ = Unknown)"
  ― ‹[routine] policy_verdict = Min over a finite enumerated list; Min = Unknown iff
       no Conflict present and some Unknown present (Compatible is the top/identity).
       Use policy_verdict_eq_Min and the linorder facts on verdict.›
  sorry

theorem unknown_sound_compatible:
  assumes "policy_verdict P Q = Unknown"
  shows   "∃Phat Qhat. completes Phat P ∧ completes Qhat Q
                      ∧ policy_verdict Phat Qhat = Compatible"
  ― ‹[main, ≈1-2 days]. Construct: for every operand a policy leaves unconstrained,
       add an Eq value lying in the other side's interval there (or any value where
       neither constrains it). Both-constrained axes were non-Conflict by assumption,
       so every operand verdict becomes Compatible.›
  sorry

theorem unknown_sound_conflict:
  assumes "policy_verdict P Q = Unknown"
    and   "∃ℓ Cj. (P ℓ = Some Cj ∧ Q ℓ = None ∨ P ℓ = None ∧ Q ℓ = Some Cj)
                  ∧ set_of Cj ≠ UNIV"
  shows   "∃Phat Qhat. completes Phat P ∧ completes Qhat Q
                      ∧ policy_verdict Phat Qhat = Conflict"
  ― ‹[main, ≈1 day]. Pick ℓ constrained by exactly one side with proper interval Cj;
       choose v outside set_of Cj; add (ℓ,Eq,v) to the other side. Then that operand
       is Conflict (criterion), so the policy verdict is Conflict (conflict_dominates).
       Complete remaining unconstrained operands as in the compatible case.›
  sorry

end
