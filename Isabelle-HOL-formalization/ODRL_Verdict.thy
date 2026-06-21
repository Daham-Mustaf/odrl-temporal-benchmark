(*  ODRL_Verdict.thy  --  def:verdict-algebra (Sec. 4.1) *)
theory ODRL_Verdict
  imports Main
begin

datatype verdict = Conflict | Unknown | Compatible

primrec vrank :: "verdict ⇒ nat" where
  "vrank Conflict   = 0"
| "vrank Unknown    = 1"
| "vrank Compatible = 2"

lemma vrank_inj: "vrank x = vrank y ⟹ x = y"
  by (cases x; cases y; simp)

instantiation verdict :: linorder
begin
  definition less_eq_verdict_def: "(x::verdict) ≤ y ⟷ vrank x ≤ vrank y"
  definition less_verdict_def:    "(x::verdict) < y ⟷ vrank x < vrank y"
  instance proof
    fix x y z :: verdict
    show "(x < y) = (x ≤ y ∧ ¬ y ≤ x)"
      by (simp add: less_eq_verdict_def less_verdict_def)
    show "x ≤ x" by (simp add: less_eq_verdict_def)
    show "x ≤ y ⟹ y ≤ z ⟹ x ≤ z" by (simp add: less_eq_verdict_def)
    show "x ≤ y ⟹ y ≤ x ⟹ x = y"
      by (metis vrank_inj less_eq_verdict_def le_antisym)
    show "x ≤ y ∨ y ≤ x" by (simp add: less_eq_verdict_def)
  qed
end

text ‹Conjunction = @{const min} (Kleene meet), disjunction = @{const max} (join),
      both free from @{class linorder}. @{const Conflict} is the bottom element.›

lemma Conflict_least [simp]: "Conflict ≤ v"
  by (cases v) (simp_all add: less_eq_verdict_def)

lemma Compatible_greatest [simp]: "v ≤ Compatible"
  by (cases v) (simp_all add: less_eq_verdict_def)

lemma min_Conflict [simp]: "min Conflict v = Conflict" "min v Conflict = Conflict"
  by (simp_all add: min_def)

end
