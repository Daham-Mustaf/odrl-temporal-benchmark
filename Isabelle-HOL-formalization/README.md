# ODRL Temporal Sort: Isabelle/HOL formalization scaffold

## TODO
Machine-checked
development  the formlisation is yet not complited!

## Build

    isabelle build -d . ODRL_Temporal

`sorry` / `oops` produce yellow warnings (expected). A red error naming a
theory and line is a real failure.

## Theory map (theory -> paper items)

| Theory | Paper items |
|---|---|
| ODRL_Verdict | def:verdict-algebra |
| ODRL_Structures | def:structures (concrete rat interpretation; shift, diff, elapsed) |
| ODRL_Intervals | def:int-op, def:sort, def:admissible, def:denotation, def:precedence, thm:criterion, lem:normalisation, def:product-denotation, thm:product-expressibility |
| ODRL_Periodic | def:ti-rec, lem:rec |
| ODRL_PolicyVerdict | def:operand-verdict, def:product-verdict, lem:conflict-propagation, prop:monotone, def:completion, thm:unknown-sound |
| ODRL_Composition | def:composition, def:branch, def:or-verdict, thm:composition-soundness |
| ODRL_Background | def:frame, def:tier, thm:tiered, cor:product-exact |
| ODRL_Sequence | def:trace, def:andseq, lem:andseq-strict, prop:collapse |
| ODRL_Runtime | def:static-conflict, def:runtime-eval, def:runtime-conflict, def:realizability, def:trace-conflict, thm:static-runtime, cor:bridge |
| ODRL_Entailment | def:refinement, lem:refine-syntax |

## Open obligations (future work)

These carry `sorry` or are stated schematically; discharging them is future work.

- ODRL_Intervals.set_of_ivl_inter (lem:normalisation) -- bound case split (~1 day)
- ODRL_Intervals.criterion (thm:criterion) -- order reasoning over `ext` (~2-3 days)
- ODRL_Intervals.product_empty_iff_factor_empty -- choice-function witness
- ODRL_Periodic.Per_inter_nonempty_iff -- existence form, algebra
- ODRL_Periodic.rec_gcd (lem:rec) -- clear-denominators + Bezout
- ODRL_PolicyVerdict.policy_verdict_eq_Min -- foldr/min = Min
- ODRL_PolicyVerdict.conflict_dominates -- induction over all_operands
- ODRL_PolicyVerdict.monotone -- min monotone over fixed list
- ODRL_PolicyVerdict.unknown_characterisation -- Min over finite enumeration
- ODRL_PolicyVerdict.unknown_sound_compatible / unknown_sound_conflict -- completions
- ODRL_Composition.xone_conflict_sound -- d_xone subset d_or, then all-pairs-disjoint
- ODRL_Background.tiered_Ord -- schematic; needs csys -> per-operand-interval projection
- ODRL_Background.tiered_Diff (thm:tiered, Diff case) -- negative-cycle = emptiness; reuse Wimmer AFP DBM
- ODRL_Sequence.andseq_strict, collapse_to_and

## The three time sinks

1. ODRL_Intervals.criterion + set_of_ivl_inter: ~3 days, pure order reasoning over `ext`.
2. ODRL_Periodic.rec_gcd + ODRL_Background Diff tier: the two arithmetic obligations.
   lem:rec = clear-denominators + Bezout (HOL-Computational_Algebra); the Diff tier is
   negative-cycle-equals-emptiness for difference systems -- reuse Simon Wimmer's AFP
   DBM / Timed-Automata material rather than reproving Bellman-Ford.
3. ODRL_Runtime / ODRL_Sequence: the trace existential and realizability as STN
   emptiness, on top of (2).

thm:tiered soundness is what to mechanize fully; its **completeness is conditional**
on Phi being domain-complete and is stated with that hypothesis explicit (phi_complete).
