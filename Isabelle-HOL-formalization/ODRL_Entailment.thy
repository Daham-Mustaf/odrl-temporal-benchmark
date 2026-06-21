(*  ODRL_Entailment.thy  --  def:refinement, lem:refine-syntax (Sec. 4.5) *)
theory ODRL_Entailment
  imports ODRL_Intervals
begin

text ‹def:refinement. C1 ⪯ C2 iff its denotation is contained.›

definition refines :: "'a::linorder ivl ⇒ 'a ivl ⇒ bool" (infix ‹⪯› 50) where
  "I ⪯ J ⟷ set_of I ⊆ set_of J"

lemma refines_refl: "I ⪯ I" by (simp add: refines_def)
lemma refines_trans: "I ⪯ J ⟹ J ⪯ K ⟹ I ⪯ K" by (auto simp: refines_def)

text ‹lem:refine-syntax. On a totally ordered domain, entailment of atomic
      constraints reduces to one comparison of right operands.›

lemma refine_lt:   ― ‹dateTime, lt: (dt,lt,r1) ⪯ (dt,lt,r2) ⟷ r1 ≤ r2›
  "den_lt r1 ⪯ den_lt r2 ⟷ r1 ≤ r2"
  by (auto simp: refines_def)

lemma refine_gt:   ― ‹dual for gt›
  "den_gt r1 ⪯ den_gt r2 ⟷ r2 ≤ r1"
  by (auto simp: refines_def)

lemma refine_lteq: ― ‹elapsedTime/meteredTime, lteq: r1 ≤ r2›
  "den_lteq r1 ⪯ den_lteq r2 ⟷ r1 ≤ r2"
  by (auto simp: refines_def)

lemma refine_gteq: ― ‹delayPeriod, gteq: r1 ≥ r2›
  "den_gteq r1 ⪯ den_gteq r2 ⟷ r2 ≤ r1"
  by (auto simp: refines_def)

text ‹Hence atomic ⪯ is decidable by a single comparison (the EPR / Ord tier).›

end
