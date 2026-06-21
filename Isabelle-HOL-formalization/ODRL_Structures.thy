(*  ODRL_Structures.thy  --  def:structures (Sec. 3) *)
theory ODRL_Structures
  imports Complex_Main
begin

text ‹
  def:structures asks for a timeline (linear order affine over (ℚ,+)) and a
  duration domain (totally ordered cancellative commutative monoid embedding
  order-preservingly into (ℚ≥0,+), closed under nonnegative instant differences),
  with a shift s+d and a difference δ(s,t)=t−s.

  Concrete interpretation that discharges every obligation by rat arithmetic:
  instants = rat, durations = rat carrying the invariant 0 ≤ d. This is enough
  for the whole metatheory; the abstract locale below is optional and only buys
  parametricity.›

type_synonym inst = rat
type_synonym dur  = rat   ― ‹nonnegative where it matters; invariant carried in predicates›

definition shift :: "inst ⇒ dur ⇒ inst" where "shift s d = s + d"
definition diff  :: "inst ⇒ inst ⇒ dur" where "diff s t = t - s"
definition is_dur :: "rat ⇒ bool" where "is_dur d ⟷ 0 ≤ d"

lemma shift_zero  [simp]: "shift s 0 = s"               by (simp add: shift_def)
lemma shift_add   [simp]: "shift (shift s d) e = shift s (d + e)" by (simp add: shift_def)
lemma shift_diff  [simp]: "shift s (diff s t) = t"      by (simp add: shift_def diff_def)
lemma diff_shift  [simp]: "diff s (shift s d) = d"      by (simp add: shift_def diff_def)
lemma diff_nonneg: "s ≤ t ⟹ is_dur (diff s t)"         by (simp add: diff_def is_dur_def)
lemma diff_mono:   "diff s t1 ≤ diff s t2 ⟷ t1 ≤ t2"    by (simp add: diff_def)

text ‹def:structures, abstract form, kept for the journal version. Interpreting
      it at @{typ rat}/@{typ rat} discharges all assumptions above.›

locale temporal_structures =
  fixes lo_t  :: "'t ⇒ 't ⇒ bool"          (infix ‹⊑› 50)
    and zero  :: 'd
    and plus  :: "'d ⇒ 'd ⇒ 'd"            (infixl ‹⊕› 65)
    and lo_d  :: "'d ⇒ 'd ⇒ bool"          (infix ‹⊴› 50)
    and shf   :: "'t ⇒ 'd ⇒ 't"
    and dff   :: "'t ⇒ 't ⇒ 'd"
  assumes t_lin:  "class.linorder lo_t (λa b. lo_t a b ∧ ¬ lo_t b a)"
    and   d_mon:  "class.linorder lo_d (λa b. lo_d a b ∧ ¬ lo_d b a)"
    and   d_assoc:"(a ⊕ b) ⊕ c = a ⊕ (b ⊕ c)"
    and   d_comm: "a ⊕ b = b ⊕ a"
    and   d_zero: "zero ⊕ a = a"
    and   d_canc: "a ⊕ c = b ⊕ c ⟹ a = b"
    and   d_least:"zero ⊴ a"
    and   shf_diff: "lo_t s t ⟹ shf s (dff s t) = t"
    and   diff_shf: "dff s (shf s d) = d"
begin
end

end
