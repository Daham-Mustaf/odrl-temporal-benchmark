# ODRL Temporal Sort: Isabelle/HOL formalization scaffold

Mechanization of "Sort-Stratified Semantics for ODRL". This is a **scaffold**:
every definition and theorem of the paper is stated; proofs are present where
confident and marked `sorry` with a plan where they are real work. Nothing here
has been machine-checked; discharge it in a running Isabelle (tested target:
Isabelle2024 / 2025).

## Build

    isabelle build -D .

## Theory map (theory  ->  paper)

| Theory                 | Paper items                                                            | Proof status |
|------------------------|-----------------------------------------------------------------------|--------------|
| `ODRL_Verdict`         | def:verdict-algebra                                                    | complete     |
| `ODRL_Structures`      | def:structures (concrete rat interpretation; shift, diff, elapsed)    | complete     |
| `ODRL_Intervals`       | def:int-op, def:sort, def:admissible, def:denotation, def:precedence, thm:criterion, lem:normalisation, def:product-denotation, thm:product-expressibility | criterion + ivl_inter = `sorry` (plans inside); rest complete |
| `ODRL_Periodic`        | def:ti-rec, lem:rec                                                    | existence form provable; gcd form = `sorry` (scale-to-int plan) |
| `ODRL_PolicyVerdict`   | def:operand-verdict, def:product-verdict, lem:conflict-propagation, prop:monotone, def:completion, thm:unknown-sound | propagation/monotone complete; unknown-sound characterization attempted, completion-existence = `sorry` |
| `ODRL_Composition`     | def:composition, def:branch, def:or-verdict, thm:composition-soundness | and/or complete; xone = `sorry` |
| `ODRL_Background`      | def:frame, def:tier, thm:tiered, cor:product-exact                     | Ord case reduces to criterion; Diff/Mod = `sorry` (DBM/Bezout plan) |
| `ODRL_Sequence`        | def:trace, def:andseq, lem:andseq-strict, prop:collapse                | strict/collapse attempted; some `sorry` |
| `ODRL_Runtime`         | def:static-conflict, def:runtime-eval, def:runtime-conflict, def:realizability, def:trace-conflict, thm:static-runtime, cor:bridge | bridge = `sorry` (depends on tiered) |
| `ODRL_Entailment`      | def:refinement, lem:refine-syntax                                     | complete     |

## The three time sinks (where the weeks go)

1. `ODRL_Intervals.criterion` (thm:criterion) and `set_of_ivl_inter` (lem:normalisation):
   ~3 days. Pure order reasoning over the adjoined-endpoint type `ext`.
2. `ODRL_Periodic.rec_gcd` (lem:rec) and `ODRL_Background` Diff tier (thm:tiered):
   the two arithmetic obligations. lem:rec needs clear-denominators + Bezout
   (`HOL-Computational_Algebra`); the Diff tier is negative-cycle-equals-emptiness
   for difference systems and is the place to reuse Simon Wimmer's AFP DBM /
   Timed-Automata material rather than reprove Bellman-Ford.
3. `ODRL_Runtime` / `ODRL_Sequence`: the trace existential and realizability as
   STN emptiness, sitting on top of (2).

Soundness of thm:tiered is what to mechanize fully; its **completeness is
conditional** on Phi being domain-complete, so it is stated with that hypothesis
explicit, not proved unconditionally.
