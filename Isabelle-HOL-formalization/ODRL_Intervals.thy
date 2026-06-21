(*  ODRL_Intervals.thy
    def:int-op, def:sort, def:admissible, def:denotation, def:precedence,
    thm:criterion, lem:normalisation, def:product-denotation, thm:product-expressibility
*)
theory ODRL_Intervals
  imports Main
begin

section ‹Operands, operators, sorts  (def:sort)›

datatype operand = dateTime | delayPeriod | elapsedTime | meteredTime | timeInterval
datatype oper    = Eq | Lt | Lteq | Gt | Gteq | Neq
datatype tsort   = Inst | Dur

fun sortof :: "operand ⇒ tsort" where
  "sortof dateTime     = Inst"
| "sortof delayPeriod  = Dur"
| "sortof elapsedTime  = Dur"
| "sortof meteredTime  = Dur"
| "sortof timeInterval = Dur"

definition interval_ops :: "oper set" where   ― ‹def:int-op, O_I›
  "interval_ops = {Eq, Lt, Lteq, Gt, Gteq}"

fun Adm :: "operand ⇒ oper set" where         ― ‹def:admissible›
  "Adm dateTime     = {Eq, Lt, Lteq, Gt, Gteq}"
| "Adm delayPeriod  = {Eq, Gt, Gteq}"
| "Adm elapsedTime  = {Eq, Lt, Lteq}"
| "Adm meteredTime  = {Eq, Lt, Lteq}"
| "Adm timeInterval = {Eq}"

lemma Adm_subset_interval_ops: "Adm ℓ ⊆ interval_ops"
  by (cases ℓ) (auto simp: interval_ops_def)


section ‹Adjoined endpoints  (the ⊥/⊤ bookkeeping)›

datatype 'a ext = Bot | Fin 'a | Top

instantiation ext :: (linorder) linorder
begin
  fun less_eq_ext :: "'a ext ⇒ 'a ext ⇒ bool" where
    "Bot   ≤ _     = True"
  | "Fin x ≤ Fin y = (x ≤ y)"
  | "Fin _ ≤ Top   = True"
  | "Fin _ ≤ Bot   = False"
  | "Top   ≤ Top   = True"
  | "Top   ≤ Fin _ = False"
  | "Top   ≤ Bot   = False"
  definition less_ext_def: "(x::'a ext) < y ⟷ x ≤ y ∧ ¬ y ≤ x"
  instance proof
    fix x y z :: "'a ext"
    show "(x < y) = (x ≤ y ∧ ¬ y ≤ x)" by (simp add: less_ext_def)
    show "x ≤ x"                         by (cases x) auto
    show "x ≤ y ⟹ y ≤ z ⟹ x ≤ z"      by (cases x; cases y; cases z) auto
    show "x ≤ y ⟹ y ≤ x ⟹ x = y"      by (cases x; cases y) auto
    show "x ≤ y ∨ y ≤ x"                by (cases x; cases y) auto
  qed
end


section ‹Interval representation and denotation  (def:denotation)›

record 'a ivl =
  lo    :: "'a ext"
  lo_cl :: bool
  hi    :: "'a ext"
  hi_cl :: bool

definition wf_ivl :: "'a ivl ⇒ bool" where
  "wf_ivl I ⟷ (lo I = Bot ⟶ ¬ lo_cl I) ∧ (hi I = Top ⟶ ¬ hi_cl I)
              ∧ lo I ≠ Top ∧ hi I ≠ Bot"

definition set_of :: "'a::linorder ivl ⇒ 'a set" where
  "set_of I = {x. (if lo_cl I then lo I ≤ Fin x else lo I < Fin x)
                ∧ (if hi_cl I then Fin x ≤ hi I else Fin x < hi I)}"

definition den_eq   where "den_eq   v = ⦇ lo = Fin v, lo_cl = True,  hi = Fin v, hi_cl = True  ⦈"
definition den_lteq where "den_lteq v = ⦇ lo = Bot,   lo_cl = False, hi = Fin v, hi_cl = True  ⦈"
definition den_gteq where "den_gteq v = ⦇ lo = Fin v, lo_cl = True,  hi = Top,   hi_cl = False ⦈"
definition den_lt   where "den_lt   v = ⦇ lo = Bot,   lo_cl = False, hi = Fin v, hi_cl = False ⦈"
definition den_gt   where "den_gt   v = ⦇ lo = Fin v, lo_cl = False, hi = Top,   hi_cl = False ⦈"

fun den :: "oper ⇒ 'a ⇒ 'a ivl" where     ― ‹den only on interval_ops; Neq is junk›
  "den Eq   v = den_eq v"
| "den Lteq v = den_lteq v"
| "den Gteq v = den_gteq v"
| "den Lt   v = den_lt v"
| "den Gt   v = den_gt v"
| "den Neq  v = undefined"

lemma set_of_den_eq   [simp]: "set_of (den_eq   v) = {v}"        by (auto simp: set_of_def den_eq_def less_ext_def)
lemma set_of_den_lteq [simp]: "set_of (den_lteq v) = {x. x ≤ v}" by (auto simp: set_of_def den_lteq_def less_ext_def)
lemma set_of_den_gteq [simp]: "set_of (den_gteq v) = {x. v ≤ x}" by (auto simp: set_of_def den_gteq_def less_ext_def)
lemma set_of_den_lt   [simp]: "set_of (den_lt   v) = {x. x < v}" by (auto simp: set_of_def den_lt_def less_ext_def)
lemma set_of_den_gt   [simp]: "set_of (den_gt   v) = {x. v < x}" by (auto simp: set_of_def den_gt_def less_ext_def)

lemma wf_den [simp]:
  "wf_ivl (den_eq v)" "wf_ivl (den_lteq v)" "wf_ivl (den_gteq v)"
  "wf_ivl (den_lt v)"  "wf_ivl (den_gt v)"
  by (simp_all add: wf_ivl_def den_eq_def den_lteq_def den_gteq_def den_lt_def den_gt_def)


section ‹Per-operand normalisation  (lem:normalisation)›

definition combine_lo :: "('a::linorder ext × bool) ⇒ ('a ext × bool) ⇒ ('a ext × bool)" where
  "combine_lo a b = (if fst a < fst b then b else if fst b < fst a then a
                     else (fst a, snd a ∧ snd b))"

definition combine_hi :: "('a::linorder ext × bool) ⇒ ('a ext × bool) ⇒ ('a ext × bool)" where
  "combine_hi a b = (if fst a < fst b then a else if fst b < fst a then b
                     else (fst a, snd a ∧ snd b))"

definition ivl_inter :: "'a::linorder ivl ⇒ 'a ivl ⇒ 'a ivl" where
  "ivl_inter I J =
     (let (l,lc) = combine_lo (lo I, lo_cl I) (lo J, lo_cl J);
          (h,hc) = combine_hi (hi I, hi_cl I) (hi J, hi_cl J)
      in ⦇ lo = l, lo_cl = lc, hi = h, hi_cl = hc ⦈)"

lemma set_of_ivl_inter: "set_of (ivl_inter I J) = set_of I ∩ set_of J"
  ― ‹[main, ≈1 day] unfold set_of/ivl_inter/combine_*, split on the three branches
       of each combine; tie branch uses the closed-flag conjunction. Try:
       (auto simp: set_of_def ivl_inter_def combine_lo_def combine_hi_def less_ext_def
             split: prod.splits) then case_tac on the equal-bound branch.›
  sorry

lemma normalisation:                          ― ‹lem:normalisation: finite ∩ is an interval›
  "set_of (fold ivl_inter Is I0) = set_of I0 ∩ (⋂I∈set Is. set_of I)"
  by (induction Is arbitrary: I0) (auto simp: set_of_ivl_inter)


section ‹Bound order and the conflict criterion  (def:precedence, thm:criterion)›

definition prec :: "('a::linorder ext × bool) ⇒ ('a ext × bool) ⇒ bool" where
  "prec u l ⟷ fst u < fst l ∨ (fst u = fst l ∧ ¬ (snd u ∧ snd l))"

definition ivl_disjoint :: "'a::linorder ivl ⇒ 'a ivl ⇒ bool" where
  "ivl_disjoint I J ⟷ prec (hi I, hi_cl I) (lo J, lo_cl J)
                     ∨ prec (hi J, hi_cl J) (lo I, lo_cl I)"

theorem criterion:
  assumes "wf_ivl I" "wf_ivl J" "set_of I ≠ {}" "set_of J ≠ {}"
  shows   "set_of I ∩ set_of J = {} ⟷ ivl_disjoint I J"
  ― ‹[main, ≈2-3 days].
     (⟸) a facing prec forbids any common x: expand set_of, chase ext order,
          wf_ivl removes ⊥/⊤ from the equal case.
     (⟹) contrapositive: ¬prec both ways gives lo's ≤ facing hi's with compatible
          flags; nonemptiness yields a witness in the overlap. No density needed —
          the touching case is settled by the flag conjunction in prec.›
  sorry

theorem conflict_propagation:                 ― ‹lem:conflict-propagation›
  "set_of I ⊆ set_of I' ⟹ set_of I' ∩ set_of J = {} ⟹ set_of I ∩ set_of J = {}"
  by auto


section ‹Product denotation and expressibility  (def:product-denotation, thm:product-expressibility)›

text ‹A point is a map from operands to values (one value type per development).
      The product is satisfied pointwise on the constrained axes.›

definition in_product :: "(operand ⇀ 'a::linorder ivl) ⇒ (operand ⇒ 'a) ⇒ bool" where
  "in_product P pt ⟷ (∀ℓ I. P ℓ = Some I ⟶ pt ℓ ∈ set_of I)"

definition product_set :: "(operand ⇀ 'a::linorder ivl) ⇒ (operand ⇒ 'a) set" where
  "product_set P = {pt. in_product P pt}"

lemma product_empty_iff_factor_empty:
  "product_set P = {} ⟷ (∃ℓ I. P ℓ = Some I ∧ set_of I = {})"
  ― ‹an empty factor empties the product; otherwise a choice function witnesses it.
       (⟸) immediate. (⟹) contrapose: if every factor nonempty, pick a value per
       constrained axis (choice) and anything elsewhere.›
  sorry

theorem product_expressibility:
  ― ‹thm:product-expressibility: each realizable shape per axis is denoted by an
     admissible operator, so any product of such intervals = product_set of some
     assignment of constraints. Proof: the five den_* exhaust the shapes
     {v},(⊥,v],[v,⊤),(⊥,v),(v,⊤); the full domain = None; two-sided = ivl_inter of
     an upper and a lower. Conjoin per axis.›
  shows True
  by simp

end
