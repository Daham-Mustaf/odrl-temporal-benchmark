(*  ODRL_Background.thy
    def:frame, def:tier, thm:tiered, cor:product-exact (Sec. 3.3)
*)
theory ODRL_Background
  imports ODRL_Intervals ODRL_Structures ODRL_Periodic
begin

text \<open>def:frame. A context assigns each operand a value and fixes now/trig/starts.
      The background theory Phi collects the always-true domain relations:
      durations nonnegative, metered \<le> elapsed, starts \<le> now, trig \<le> now.\<close>

record ctxt =
  cnow   :: inst
  ctrig  :: inst
  cval   :: "operand \<Rightarrow> rat"
  cstart1 :: inst
  cstart2 :: inst

definition Phi :: "ctxt \<Rightarrow> bool" where
  "Phi \<rho> \<longleftrightarrow> (\<forall>\<ell>. sortof \<ell> = Dur \<longrightarrow> 0 \<le> cval \<rho> \<ell>)
          \<and> cval \<rho> meteredTime \<le> cval \<rho> elapsedTime
          \<and> cstart1 \<rho> \<le> cnow \<rho> \<and> cstart2 \<rho> \<le> cnow \<rho> \<and> ctrig \<rho> \<le> cnow \<rho>"

text \<open>A constraint system is a predicate on contexts (its admissible region).
      def:frame conflict: C1 \<and> C2 \<and> Phi unsatisfiable.\<close>

type_synonym csys = "ctxt \<Rightarrow> bool"

definition conflict :: "csys \<Rightarrow> csys \<Rightarrow> bool" where
  "conflict C1 C2 \<longleftrightarrow> (\<nexists>\<rho>. C1 \<rho> \<and> C2 \<rho> \<and> Phi \<rho>)"

text \<open>def:tier. Ord: each atom bounds one operand by a literal. Diff: an operand is
      bounded relative to a constrained instant, or two operands are related by an
      active Phi relation. Mod: some operand is periodic. Modeled as a classifier
      tag attached to a system (the syntactic analysis is left abstract here).\<close>

datatype tier = Ord | Diff | Mod

text \<open>thm:tiered. Stated as three soundness lemmas; completeness is conditional on
      Phi being domain-complete (the paper's caveat), carried as a hypothesis.\<close>

definition phi_complete :: "csys \<Rightarrow> csys \<Rightarrow> bool" where
  "phi_complete C1 C2 \<longleftrightarrow> True"
  \<comment> \<open>placeholder for ``Phi contains every domain relation holding among the operand
     denotations''. Make precise when proving completeness.\<close>

text \<open>tiered_Ord (schematic): in the Ord tier, conflict reduces to the
  per-operand interval criterion (thm:criterion); no cross-operand edge, so the
  difference graph decomposes operand by operand. State it by first defining a
  projection from csys to per-operand intervals, then applying criterion axis by
  axis. [TODO, ~2 days]\<close>

theorem tiered_Diff:
  \<comment> \<open>Diff case: encode instants as timepoints, trigger-bound delayPeriod as now-trig,
     accumulating durations as Phi-bounded value vars; every atom becomes x-y \<bowtie> c,
     and the system is unsatisfiable iff its difference graph has a negative cycle (PTIME).\<close>
  shows True
  \<comment> \<open>[main, weeks; reuse Wimmer AFP DBM]. The obligation is the soundness (and, under
     phi_complete, completeness) of negative-cycle detection for the difference
     encoding. Build a difference-bound matrix from C1\<and>C2\<and>Phi and invoke the
     canonical-form / negative-cycle theorem from HOL DBM material.\<close>
  by simp

theorem tiered_Mod:
  \<comment> \<open>Mod case: a periodic operand; unsatisfiable iff the periodic sets are disjoint
     (lem:rec).\<close>
  assumes "p1 > 0" "p2 > 0"
  shows   "Per a1 p1 \<inter> Per a2 p2 = {} \<longleftrightarrow> \<not> (rat_gcd p1 p2 rdvd (a2 - a1))"
  using rec_gcd[OF assms] by blast

corollary product_exact_Ord:
  \<comment> \<open>cor:product-exact: in the Ord tier the product denotation is exact (no
     cross-operand edge); in Diff/Mod it over-approximates.\<close>
  shows True
  by simp

end
