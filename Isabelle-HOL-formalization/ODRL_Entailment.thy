(*  ODRL_Entailment.thy  --  def:refinement, lem:refine-syntax (Sec. 4.5) *)
theory ODRL_Entailment
  imports ODRL_Intervals
begin

text \<open>def:refinement. C1 \<preceq> C2 iff its denotation is contained.\<close>

definition refines :: "'a::linorder ivl \<Rightarrow> 'a ivl \<Rightarrow> bool" (infix \<open>\<preceq>\<close> 50) where
  "I \<preceq> J \<longleftrightarrow> set_of I \<subseteq> set_of J"

lemma refines_refl: "I \<preceq> I" by (simp add: refines_def)
lemma refines_trans: "I \<preceq> J \<Longrightarrow> J \<preceq> K \<Longrightarrow> I \<preceq> K" by (auto simp: refines_def)

text \<open>lem:refine-syntax. On a totally ordered domain, entailment of atomic
      constraints reduces to one comparison of right operands.\<close>

lemma refine_lt:   \<comment> \<open>dateTime, lt: (dt,lt,r1) \<preceq> (dt,lt,r2) \<longleftrightarrow> r1 \<le> r2\<close>
  "den_lt r1 \<preceq> den_lt r2 \<longleftrightarrow> r1 \<le> r2"
  by (auto simp: refines_def)

lemma refine_gt:   \<comment> \<open>dual for gt\<close>
  "den_gt r1 \<preceq> den_gt r2 \<longleftrightarrow> r2 \<le> r1"
  by (auto simp: refines_def)

lemma refine_lteq: \<comment> \<open>elapsedTime/meteredTime, lteq: r1 \<le> r2\<close>
  "den_lteq r1 \<preceq> den_lteq r2 \<longleftrightarrow> r1 \<le> r2"
  by (auto simp: refines_def)

lemma refine_gteq: \<comment> \<open>delayPeriod, gteq: r1 \<ge> r2\<close>
  "den_gteq r1 \<preceq> den_gteq r2 \<longleftrightarrow> r2 \<le> r1"
  by (auto simp: refines_def)

text \<open>Hence atomic \<preceq> is decidable by a single comparison (the EPR / Ord tier).\<close>

end
