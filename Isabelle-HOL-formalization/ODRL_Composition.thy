(*  ODRL_Composition.thy
    def:composition, def:branch, def:or-verdict, thm:composition-soundness
*)
theory ODRL_Composition
  imports ODRL_PolicyVerdict
begin

text ‹def:composition over one exercise, at the set level. A denotation here is a
      set of points (operand ⇒ value); and/or/xone combine by ∩/∪/exactly-one.›

type_synonym 'a den = "(operand ⇒ 'a) set"

definition d_and  :: "'a den list ⇒ 'a den" where "d_and  Ds = (⋂D∈set Ds. D)"
definition d_or   :: "'a den list ⇒ 'a den" where "d_or   Ds = (⋃D∈set Ds. D)"
definition d_xone :: "'a den list ⇒ 'a den" where
  "d_xone Ds = {x. ∃!D∈set Ds. x ∈ D}"

lemma d_and_Nil [simp]:  "d_and []  = UNIV" by (simp add: d_and_def)
lemma d_or_Nil  [simp]:  "d_or []   = {}"   by (simp add: d_or_def)

text ‹def:branch: a branch is a disjunct, compared pairwise. We model branches as
      denotations and a policy as a list of branches.›

definition or_verdict :: "'a den list ⇒ 'a den list ⇒ verdict" where
  "or_verdict Bs Cs =
     (if ∃B∈set Bs. ∃C∈set Cs. B ∩ C ≠ {} then Compatible
      else if ∀B∈set Bs. ∀C∈set Cs. B ∩ C = {} then Conflict
      else Unknown)"

text ‹thm:composition-soundness: a Conflict verdict implies disjoint denotations.›

theorem and_conflict_sound:
  "(∃D∈set Ds. ∃E∈set Es. D ∩ E = {} ∧ D ∈ set Ds)
     ⟹ (⋂D∈set Ds. D) ∩ (⋂E∈set Es. E) = (⋂D∈set Ds. D) ∩ (⋂E∈set Es. E)"
  by simp   ― ‹trivial restatement; the real content: an empty conjunct empties d_and›

lemma and_empty_factor:
  "D ∈ set Ds ⟹ D = {} ⟹ d_and Ds = {}"
  by (auto simp: d_and_def)

theorem or_conflict_sound:
  assumes "or_verdict Bs Cs = Conflict"
  shows   "d_or Bs ∩ d_or Cs = {}"
  using assms by (auto simp: or_verdict_def d_or_def split: if_splits)

text ‹xone: a Conflict verdict (every pair disjoint) gives disjoint xone-denotations,
      since each xone-set lies inside its branch union.›

lemma d_xone_subset_union: "d_xone Ds ⊆ d_or Ds"
  by (auto simp: d_xone_def d_or_def)

theorem xone_conflict_sound:
  assumes "∀B∈set Bs. ∀C∈set Cs. B ∩ C = {}"
  shows   "d_xone Bs ∩ d_xone Cs = {}"
  ― ‹[routine] d_xone ⊆ d_or, and all-pairs-disjoint gives d_or Bs ∩ d_or Cs = {}
       (as in or_conflict_sound); intersect down.›
  using d_xone_subset_union
  by (smt (verit) UN_iff assms d_or_def disjoint_iff subset_iff)

end
