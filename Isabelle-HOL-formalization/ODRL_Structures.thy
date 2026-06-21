(*  ODRL_Structures.thy  --  def:structures (Sec. 3) *)
theory ODRL_Structures
  imports Complex_Main
begin

text \<open>
  def:structures asks for a timeline (linear order affine over (\<rat>,+)) and a
  duration domain (totally ordered cancellative commutative monoid embedding
  order-preservingly into (\<rat>\<ge>0,+), closed under nonnegative instant differences),
  with a shift s+d and a difference \<delta>(s,t)=t-s.

  Concrete interpretation that discharges every obligation by rat arithmetic:
  instants = rat, durations = rat carrying the invariant 0 \<le> d. This is enough
  for the whole metatheory; the abstract locale below is optional and only buys
  parametricity.\<close>

type_synonym inst = rat
type_synonym dur  = rat   \<comment> \<open>nonnegative where it matters; invariant carried in predicates\<close>

definition shift :: "inst \<Rightarrow> dur \<Rightarrow> inst" where "shift s d = s + d"
definition diff  :: "inst \<Rightarrow> inst \<Rightarrow> dur" where "diff s t = t - s"
definition is_dur :: "rat \<Rightarrow> bool" where "is_dur d \<longleftrightarrow> 0 \<le> d"

lemma shift_zero  [simp]: "shift s 0 = s"               by (simp add: shift_def)
lemma shift_add   [simp]: "shift (shift s d) e = shift s (d + e)" by (simp add: shift_def)
lemma shift_diff  [simp]: "shift s (diff s t) = t"      by (simp add: shift_def diff_def)
lemma diff_shift  [simp]: "diff s (shift s d) = d"      by (simp add: shift_def diff_def)
lemma diff_nonneg: "s \<le> t \<Longrightarrow> is_dur (diff s t)"         by (simp add: diff_def is_dur_def)
lemma diff_mono:   "diff s t1 \<le> diff s t2 \<longleftrightarrow> t1 \<le> t2"    by (simp add: diff_def)

text \<open>def:structures, abstract form, kept for the journal version. Interpreting
      it at @{typ rat}/@{typ rat} discharges all assumptions above.\<close>

locale temporal_structures =
  fixes lo_t  :: "'t \<Rightarrow> 't \<Rightarrow> bool"          (infix \<open>\<sqsubseteq>\<close> 50)
    and zero  :: 'd
    and plus  :: "'d \<Rightarrow> 'd \<Rightarrow> 'd"            (infixl \<open>\<oplus>\<close> 65)
    and lo_d  :: "'d \<Rightarrow> 'd \<Rightarrow> bool"          (infix \<open>\<unlhd>\<close> 50)
    and shf   :: "'t \<Rightarrow> 'd \<Rightarrow> 't"
    and dff   :: "'t \<Rightarrow> 't \<Rightarrow> 'd"
  assumes t_lin:  "class.linorder lo_t (\<lambda>a b. lo_t a b \<and> \<not> lo_t b a)"
    and   d_mon:  "class.linorder lo_d (\<lambda>a b. lo_d a b \<and> \<not> lo_d b a)"
    and   d_assoc:"(a \<oplus> b) \<oplus> c = a \<oplus> (b \<oplus> c)"
    and   d_comm: "a \<oplus> b = b \<oplus> a"
    and   d_zero: "zero \<oplus> a = a"
    and   d_canc: "a \<oplus> c = b \<oplus> c \<Longrightarrow> a = b"
    and   d_least:"zero \<unlhd> a"
    and   shf_diff: "lo_t s t \<Longrightarrow> shf s (dff s t) = t"
    and   diff_shf: "dff s (shf s d) = d"
begin
end

end
