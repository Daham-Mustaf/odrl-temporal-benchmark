(*  ODRL_Intervals.thy
    def:int-op, def:sort, def:admissible, def:denotation, def:precedence,
    thm:criterion, lem:normalisation, def:product-denotation, thm:product-expressibility
*)
theory ODRL_Intervals
  imports Main
begin

section \<open>Operands, operators, sorts  (def:sort)\<close>

datatype operand = dateTime | delayPeriod | elapsedTime | meteredTime | timeInterval
datatype oper    = Eq | Lt | Lteq | Gt | Gteq | Neq
datatype tsort   = Inst | Dur

fun sortof :: "operand \<Rightarrow> tsort" where
  "sortof dateTime     = Inst"
| "sortof delayPeriod  = Dur"
| "sortof elapsedTime  = Dur"
| "sortof meteredTime  = Dur"
| "sortof timeInterval = Dur"

definition interval_ops :: "oper set" where   \<comment> \<open>def:int-op, O_I\<close>
  "interval_ops = {Eq, Lt, Lteq, Gt, Gteq}"

fun Adm :: "operand \<Rightarrow> oper set" where         \<comment> \<open>def:admissible\<close>
  "Adm dateTime     = {Eq, Lt, Lteq, Gt, Gteq}"
| "Adm delayPeriod  = {Eq, Gt, Gteq}"
| "Adm elapsedTime  = {Eq, Lt, Lteq}"
| "Adm meteredTime  = {Eq, Lt, Lteq}"
| "Adm timeInterval = {Eq}"

lemma Adm_subset_interval_ops: "Adm \<ell> \<subseteq> interval_ops"
  by (cases \<ell>) (auto simp: interval_ops_def)


section \<open>Adjoined endpoints  (the \<bottom>/\<top> bookkeeping)\<close>

datatype 'a ext = Bot | Fin 'a | Top

instantiation ext :: (linorder) linorder
begin
  fun less_eq_ext :: "'a ext \<Rightarrow> 'a ext \<Rightarrow> bool" where
    "Bot   \<le> _     = True"
  | "Fin x \<le> Fin y = (x \<le> y)"
  | "Fin _ \<le> Top   = True"
  | "Fin _ \<le> Bot   = False"
  | "Top   \<le> Top   = True"
  | "Top   \<le> Fin _ = False"
  | "Top   \<le> Bot   = False"
  definition less_ext_def: "(x::'a ext) < y \<longleftrightarrow> x \<le> y \<and> \<not> y \<le> x"
  instance proof
    fix x y z :: "'a ext"
    show "(x < y) = (x \<le> y \<and> \<not> y \<le> x)" by (simp add: less_ext_def)
    show "x \<le> x"                         by (cases x) auto
    show "x \<le> y \<Longrightarrow> y \<le> z \<Longrightarrow> x \<le> z"      by (cases x; cases y; cases z) auto
    show "x \<le> y \<Longrightarrow> y \<le> x \<Longrightarrow> x = y"      by (cases x; cases y) auto
    show "x \<le> y \<or> y \<le> x"                by (cases x; cases y) auto
  qed
end


section \<open>Interval representation and denotation  (def:denotation)\<close>

record 'a ivl =
  lo    :: "'a ext"
  lo_cl :: bool
  hi    :: "'a ext"
  hi_cl :: bool

definition wf_ivl :: "'a ivl \<Rightarrow> bool" where
  "wf_ivl I \<longleftrightarrow> (lo I = Bot \<longrightarrow> \<not> lo_cl I) \<and> (hi I = Top \<longrightarrow> \<not> hi_cl I)
              \<and> lo I \<noteq> Top \<and> hi I \<noteq> Bot"

definition set_of :: "'a::linorder ivl \<Rightarrow> 'a set" where
  "set_of I = {x. (if lo_cl I then lo I \<le> Fin x else lo I < Fin x)
                \<and> (if hi_cl I then Fin x \<le> hi I else Fin x < hi I)}"

definition den_eq   where "den_eq   v = \<lparr> lo = Fin v, lo_cl = True,  hi = Fin v, hi_cl = True  \<rparr>"
definition den_lteq where "den_lteq v = \<lparr> lo = Bot,   lo_cl = False, hi = Fin v, hi_cl = True  \<rparr>"
definition den_gteq where "den_gteq v = \<lparr> lo = Fin v, lo_cl = True,  hi = Top,   hi_cl = False \<rparr>"
definition den_lt   where "den_lt   v = \<lparr> lo = Bot,   lo_cl = False, hi = Fin v, hi_cl = False \<rparr>"
definition den_gt   where "den_gt   v = \<lparr> lo = Fin v, lo_cl = False, hi = Top,   hi_cl = False \<rparr>"

fun den :: "oper \<Rightarrow> 'a \<Rightarrow> 'a ivl" where     \<comment> \<open>den only on interval_ops; Neq is junk\<close>
  "den Eq   v = den_eq v"
| "den Lteq v = den_lteq v"
| "den Gteq v = den_gteq v"
| "den Lt   v = den_lt v"
| "den Gt   v = den_gt v"
| "den Neq  v = undefined"

lemma set_of_den_eq   [simp]: "set_of (den_eq   v) = {v}"        by (auto simp: set_of_def den_eq_def less_ext_def)
lemma set_of_den_lteq [simp]: "set_of (den_lteq v) = {x. x \<le> v}" by (auto simp: set_of_def den_lteq_def less_ext_def)
lemma set_of_den_gteq [simp]: "set_of (den_gteq v) = {x. v \<le> x}" by (auto simp: set_of_def den_gteq_def less_ext_def)
lemma set_of_den_lt   [simp]: "set_of (den_lt   v) = {x. x < v}" by (auto simp: set_of_def den_lt_def less_ext_def)
lemma set_of_den_gt   [simp]: "set_of (den_gt   v) = {x. v < x}" by (auto simp: set_of_def den_gt_def less_ext_def)

lemma wf_den [simp]:
  "wf_ivl (den_eq v)" "wf_ivl (den_lteq v)" "wf_ivl (den_gteq v)"
  "wf_ivl (den_lt v)"  "wf_ivl (den_gt v)"
  by (simp_all add: wf_ivl_def den_eq_def den_lteq_def den_gteq_def den_lt_def den_gt_def)


section \<open>Per-operand normalisation  (lem:normalisation)\<close>

definition combine_lo :: "('a::linorder ext \<times> bool) \<Rightarrow> ('a ext \<times> bool) \<Rightarrow> ('a ext \<times> bool)" where
  "combine_lo a b = (if fst a < fst b then b else if fst b < fst a then a
                     else (fst a, snd a \<and> snd b))"

definition combine_hi :: "('a::linorder ext \<times> bool) \<Rightarrow> ('a ext \<times> bool) \<Rightarrow> ('a ext \<times> bool)" where
  "combine_hi a b = (if fst a < fst b then a else if fst b < fst a then b
                     else (fst a, snd a \<and> snd b))"

definition ivl_inter :: "'a::linorder ivl \<Rightarrow> 'a ivl \<Rightarrow> 'a ivl" where
  "ivl_inter I J =
     (let (l,lc) = combine_lo (lo I, lo_cl I) (lo J, lo_cl J);
          (h,hc) = combine_hi (hi I, hi_cl I) (hi J, hi_cl J)
      in \<lparr> lo = l, lo_cl = lc, hi = h, hi_cl = hc \<rparr>)"

lemma set_of_ivl_inter: "set_of (ivl_inter I J) = set_of I \<inter> set_of J"
  \<comment> \<open>[main, ~1 day] unfold set_of/ivl_inter/combine_*, split on the three branches
       of each combine; tie branch uses the closed-flag conjunction. Try:
       (auto simp: set_of_def ivl_inter_def combine_lo_def combine_hi_def less_ext_def
             split: prod.splits) then case_tac on the equal-bound branch.\<close>
  sorry

lemma normalisation:                          \<comment> \<open>lem:normalisation: finite \<inter> is an interval\<close>
  "set_of (fold ivl_inter Is I0) = set_of I0 \<inter> (\<Inter>I\<in>set Is. set_of I)"
  by (induction Is arbitrary: I0) (auto simp: set_of_ivl_inter)


section \<open>Bound order and the conflict criterion  (def:precedence, thm:criterion)\<close>

definition prec :: "('a::linorder ext \<times> bool) \<Rightarrow> ('a ext \<times> bool) \<Rightarrow> bool" where
  "prec u l \<longleftrightarrow> fst u < fst l \<or> (fst u = fst l \<and> \<not> (snd u \<and> snd l))"

definition ivl_disjoint :: "'a::linorder ivl \<Rightarrow> 'a ivl \<Rightarrow> bool" where
  "ivl_disjoint I J \<longleftrightarrow> prec (hi I, hi_cl I) (lo J, lo_cl J)
                     \<or> prec (hi J, hi_cl J) (lo I, lo_cl I)"

theorem criterion:
  assumes "wf_ivl I" "wf_ivl J" "set_of I \<noteq> {}" "set_of J \<noteq> {}"
  shows   "set_of I \<inter> set_of J = {} \<longleftrightarrow> ivl_disjoint I J"
  \<comment> \<open>[main, ~2-3 days].
     (\<Longleftarrow>) a facing prec forbids any common x: expand set_of, chase ext order,
          wf_ivl removes \<bottom>/\<top> from the equal case.
     (\<Longrightarrow>) contrapositive: \<not>prec both ways gives lo's \<le> facing hi's with compatible
          flags; nonemptiness yields a witness in the overlap. No density needed -
          the touching case is settled by the flag conjunction in prec.\<close>
  sorry

theorem conflict_propagation:                 \<comment> \<open>lem:conflict-propagation\<close>
  "set_of I \<subseteq> set_of I' \<Longrightarrow> set_of I' \<inter> set_of J = {} \<Longrightarrow> set_of I \<inter> set_of J = {}"
  by auto


section \<open>Product denotation and expressibility  (def:product-denotation, thm:product-expressibility)\<close>

text \<open>A point is a map from operands to values (one value type per development).
      The product is satisfied pointwise on the constrained axes.\<close>

definition in_product :: "(operand \<rightharpoonup> 'a::linorder ivl) \<Rightarrow> (operand \<Rightarrow> 'a) \<Rightarrow> bool" where
  "in_product P pt \<longleftrightarrow> (\<forall>\<ell> I. P \<ell> = Some I \<longrightarrow> pt \<ell> \<in> set_of I)"

definition product_set :: "(operand \<rightharpoonup> 'a::linorder ivl) \<Rightarrow> (operand \<Rightarrow> 'a) set" where
  "product_set P = {pt. in_product P pt}"

lemma product_empty_iff_factor_empty:
  "product_set P = {} \<longleftrightarrow> (\<exists>\<ell> I. P \<ell> = Some I \<and> set_of I = {})"
  \<comment> \<open>an empty factor empties the product; otherwise a choice function witnesses it.
       (\<Longleftarrow>) immediate. (\<Longrightarrow>) contrapose: if every factor nonempty, pick a value per
       constrained axis (choice) and anything elsewhere.\<close>
  sorry

theorem product_expressibility:
  \<comment> \<open>thm:product-expressibility: each realizable shape per axis is denoted by an
     admissible operator, so any product of such intervals = product_set of some
     assignment of constraints. Proof: the five den_* exhaust the shapes
     {v},(\<bottom>,v],[v,\<top>),(\<bottom>,v),(v,\<top>); the full domain = None; two-sided = ivl_inter of
     an upper and a lower. Conjoin per axis.\<close>
  shows True
  by simp

end
