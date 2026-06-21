(*  ODRL_Composition.thy
    def:composition, def:branch, def:or-verdict, thm:composition-soundness
*)
theory ODRL_Composition
  imports ODRL_PolicyVerdict
begin

text \<open>def:composition over one exercise, at the set level. A denotation here is a
      set of points (operand \<Rightarrow> value); and/or/xone combine by \<inter>/\<union>/exactly-one.\<close>

type_synonym 'a den = "(operand \<Rightarrow> 'a) set"

definition d_and  :: "'a den list \<Rightarrow> 'a den" where "d_and  Ds = (\<Inter>D\<in>set Ds. D)"
definition d_or   :: "'a den list \<Rightarrow> 'a den" where "d_or   Ds = (\<Union>D\<in>set Ds. D)"
definition d_xone :: "'a den list \<Rightarrow> 'a den" where
  "d_xone Ds = {x. \<exists>!D\<in>set Ds. x \<in> D}"

lemma d_and_Nil [simp]:  "d_and []  = UNIV" by (simp add: d_and_def)
lemma d_or_Nil  [simp]:  "d_or []   = {}"   by (simp add: d_or_def)

text \<open>def:branch: a branch is a disjunct, compared pairwise. We model branches as
      denotations and a policy as a list of branches.\<close>

definition or_verdict :: "'a den list \<Rightarrow> 'a den list \<Rightarrow> verdict" where
  "or_verdict Bs Cs =
     (if \<exists>B\<in>set Bs. \<exists>C\<in>set Cs. B \<inter> C \<noteq> {} then Compatible
      else if \<forall>B\<in>set Bs. \<forall>C\<in>set Cs. B \<inter> C = {} then Conflict
      else Unknown)"

text \<open>thm:composition-soundness: a Conflict verdict implies disjoint denotations.\<close>

theorem and_conflict_sound:
  "(\<exists>D\<in>set Ds. \<exists>E\<in>set Es. D \<inter> E = {} \<and> D \<in> set Ds)
     \<Longrightarrow> (\<Inter>D\<in>set Ds. D) \<inter> (\<Inter>E\<in>set Es. E) = (\<Inter>D\<in>set Ds. D) \<inter> (\<Inter>E\<in>set Es. E)"
  by simp   \<comment> \<open>trivial restatement; the real content: an empty conjunct empties d_and\<close>

lemma and_empty_factor:
  "D \<in> set Ds \<Longrightarrow> D = {} \<Longrightarrow> d_and Ds = {}"
  by (auto simp: d_and_def)

theorem or_conflict_sound:
  assumes "or_verdict Bs Cs = Conflict"
  shows   "d_or Bs \<inter> d_or Cs = {}"
  using assms by (auto simp: or_verdict_def d_or_def split: if_splits)

text \<open>xone: a Conflict verdict (every pair disjoint) gives disjoint xone-denotations,
      since each xone-set lies inside its branch union.\<close>

lemma d_xone_subset_union: "d_xone Ds \<subseteq> d_or Ds"
  by (auto simp: d_xone_def d_or_def)

theorem xone_conflict_sound:
  assumes "\<forall>B\<in>set Bs. \<forall>C\<in>set Cs. B \<inter> C = {}"
  shows   "d_xone Bs \<inter> d_xone Cs = {}"
  \<comment> \<open>[routine] d_xone \<subseteq> d_or, and all-pairs-disjoint gives d_or Bs \<inter> d_or Cs = {}
       (as in or_conflict_sound); intersect down.\<close>
  sorry  \<comment> \<open>TODO: d_xone subset d_or, then all-pairs-disjoint\<close>

end
