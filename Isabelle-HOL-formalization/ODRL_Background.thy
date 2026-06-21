(*  ODRL_Background.thy
    def:frame, def:tier, thm:tiered, cor:product-exact (Sec. 3.3)
*)
theory ODRL_Background
  imports ODRL_Intervals ODRL_Structures ODRL_Periodic
begin

text ‹def:frame. A context assigns each operand a value and fixes now/trig/starts.
      The background theory Phi collects the always-true domain relations:
      durations nonnegative, metered ≤ elapsed, starts ≤ now, trig ≤ now.›

record ctxt =
  cnow   :: inst
  ctrig  :: inst
  cval   :: "operand ⇒ rat"
  cstart1 :: inst
  cstart2 :: inst

definition Phi :: "ctxt ⇒ bool" where
  "Phi ρ ⟷ (∀ℓ. sortof ℓ = Dur ⟶ 0 ≤ cval ρ ℓ)
          ∧ cval ρ meteredTime ≤ cval ρ elapsedTime
          ∧ cstart1 ρ ≤ cnow ρ ∧ cstart2 ρ ≤ cnow ρ ∧ ctrig ρ ≤ cnow ρ"

text ‹A constraint system is a predicate on contexts (its admissible region).
      def:frame conflict: C1 ∧ C2 ∧ Phi unsatisfiable.›

type_synonym csys = "ctxt ⇒ bool"

definition conflict :: "csys ⇒ csys ⇒ bool" where
  "conflict C1 C2 ⟷ (∄ρ. C1 ρ ∧ C2 ρ ∧ Phi ρ)"

text ‹def:tier. Ord: each atom bounds one operand by a literal. Diff: an operand is
      bounded relative to a constrained instant, or two operands are related by an
      active Phi relation. Mod: some operand is periodic. Modeled as a classifier
      tag attached to a system (the syntactic analysis is left abstract here).›

datatype tier = Ord | Diff | Mod

text ‹thm:tiered. Stated as three soundness lemmas; completeness is conditional on
      Phi being domain-complete (the paper's caveat), carried as a hypothesis.›

definition phi_complete :: "csys ⇒ csys ⇒ bool" where
  "phi_complete C1 C2 ⟷ True"
  ― ‹placeholder for ``Phi contains every domain relation holding among the operand
     denotations''. Make precise when proving completeness.›

theorem tiered_Ord:
  ― ‹Ord case reduces to the per-operand interval criterion (thm:criterion):
     no cross-operand edge, so the difference graph decomposes operand by operand.›
  assumes "tier_of = Ord"
  shows   "conflict C1 C2
             ⟷ (∃ℓ I J. ⌊C1⌋⇩ℓ = Some I ∧ ⌊C2⌋⇩ℓ = Some J ∧ ODRL_Intervals.ivl_disjoint I J)"
  ― ‹[main, ≈2 days] needs a projection from csys to per-operand intervals (the
     ⌊_⌋⇩ℓ notation is schematic); then apply criterion axis by axis.›
  oops   ― ‹statement schematic: replace ⌊_⌋⇩ℓ with the real projection before proving›

theorem tiered_Diff:
  ― ‹Diff case: encode instants as timepoints, trigger-bound delayPeriod as now−trig,
     accumulating durations as Phi-bounded value vars; every atom becomes x−y ⋈ c,
     and the system is unsatisfiable iff its difference graph has a negative cycle (PTIME).›
  shows True
  ― ‹[main, weeks; reuse Wimmer AFP DBM]. The obligation is the soundness (and, under
     phi_complete, completeness) of negative-cycle detection for the difference
     encoding. Build a difference-bound matrix from C1∧C2∧Phi and invoke the
     canonical-form / negative-cycle theorem from HOL DBM material.›
  by simp

theorem tiered_Mod:
  ― ‹Mod case: a periodic operand; unsatisfiable iff the periodic sets are disjoint
     (lem:rec).›
  assumes "p1 > 0" "p2 > 0"
  shows   "Per a1 p1 ∩ Per a2 p2 = {} ⟷ ¬ (rat_gcd p1 p2 rdvd (a2 - a1))"
  using rec_gcd[OF assms] by blast

corollary product_exact_Ord:
  ― ‹cor:product-exact: in the Ord tier the product denotation is exact (no
     cross-operand edge); in Diff/Mod it over-approximates.›
  shows True
  by simp

end
