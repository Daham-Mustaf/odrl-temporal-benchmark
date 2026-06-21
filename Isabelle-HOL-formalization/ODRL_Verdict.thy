(*  ODRL_Verdict.thy  --  def:verdict-algebra (Sec. 4.1) *)
theory ODRL_Verdict
  imports Main
begin

datatype verdict = Conflict | Unknown | Compatible

primrec vrank :: "verdict \<Rightarrow> nat" where
  "vrank Conflict   = 0"
| "vrank Unknown    = 1"
| "vrank Compatible = 2"

lemma vrank_inj: "vrank x = vrank y \<Longrightarrow> x = y"
  by (cases x; cases y; simp)

instantiation verdict :: linorder
begin
  definition less_eq_verdict_def: "(x::verdict) \<le> y \<longleftrightarrow> vrank x \<le> vrank y"
  definition less_verdict_def:    "(x::verdict) < y \<longleftrightarrow> vrank x < vrank y"
  instance proof
    fix x y z :: verdict
    show "(x < y) = (x \<le> y \<and> \<not> y \<le> x)"
      by (simp add: less_eq_verdict_def less_verdict_def)
    show "x \<le> x" by (simp add: less_eq_verdict_def)
    show "x \<le> y \<Longrightarrow> y \<le> z \<Longrightarrow> x \<le> z" by (simp add: less_eq_verdict_def)
    show "x \<le> y \<Longrightarrow> y \<le> x \<Longrightarrow> x = y"
      by (metis vrank_inj less_eq_verdict_def le_antisym)
    show "x \<le> y \<or> y \<le> x" by (simp add: less_eq_verdict_def)
  qed
end

text \<open>Conjunction = @{const min} (Kleene meet), disjunction = @{const max} (join),
      both free from @{class linorder}. @{const Conflict} is the bottom element.\<close>

lemma Conflict_least [simp]: "Conflict \<le> v"
  by (cases v) (simp_all add: less_eq_verdict_def)

lemma Compatible_greatest [simp]: "v \<le> Compatible"
  by (cases v) (simp_all add: less_eq_verdict_def)

lemma min_Conflict [simp]: "min Conflict v = Conflict" "min v Conflict = Conflict"
  by (simp_all add: min_def)

end
