# ODRL Temporal Conflict-Detection Benchmark

A benchmark of 71 conflict-detection problems over the temporal operands of ODRL
(`dateTime`, `delayPeriod`, `elapsedTime`, `meteredTime`, `timeInterval`),
accompanying the paper *Sort-Stratified Semantics for ODRL* (Mustafa et al., LPAR-26).

Each problem is emitted in two formats from a single description: a TPTP `.p` file
(for the first-order provers Vampire and E) and an SMT-LIB `.smt2` file (for the SMT
solvers Z3 and cvc5), together with the ODRL policy pair as Turtle (`.ttl`). The two
encodings are independent and are cross-validated against each other and across the
four reasoners.

## Contents

- 71 problems in 15 categories, IDs ODRL800 to ODRL870
- 8 background axiom families (order, duration, denotation and the verdict algebra,
  precedence; recurrence, the cross-operand frame condition, and the simple temporal
  network are inlined in the arithmetic tiers)
- generators that produce every problem and axiom in both formats

Categories: single-operand intervals, periodic recurrence, the cross-operand frame
condition, the running example (capstone, in joint and verdict-vector forms),
`andSequence` over a simple temporal network, the conflict criterion, the static and
runtime distinction, `or`, `xone`, the three-valued `unknown` verdict, refinement,
completion, `and` composition, single-policy realizability, and the sort-stratification
ablation.

## Layout

```
Problems/      the generated problems, one directory per category (.p, .smt2, .ttl,
               and a self-contained copy of the background Axioms)
Generators/    problem_data_*.py, writers.py, header.py, temporal_axiom_data.py,
               gen_temporal_axioms.py, gen_problems.py, run_reasoners.sh
```

## Requirements

- `vampire`, `eprover`, `z3`, and `cvc5` on your `PATH`
- Python 3 (the generators run under `uv run` or `python3`)

## Running

Run all four reasoners over a category, with a per-problem timeout in seconds:

```bash
bash Generators/run_reasoners.sh Problems/<Category> 20
uv run check_benchmark.py Problems --timeout 20
```

Vampire and E are run over the `.p` files, Z3 and cvc5 over the `.smt2` files. Each
reasoner's reported status is checked against the expected status stored in the problem,
and the script reports `pass` and `fail` counts.

## Regenerating

```bash
cd ~/odrl-temporal-benchmark
uv run Generators/gen_temporal_axioms.py Problems/Axioms
uv run Generators/gen_problems.py Problems
```

(adjust the paths to your checkout layout)

## Verdicts and SZS status

Every problem stores its expected status. On the first-order side each problem is posed
as the conjecture a correct detector should prove, so its expected status is `Theorem`:
a conflict as a universally quantified non-overlap, a compatibility as a witness, and the
three-valued cases as an equation over the verdict algebra. The SMT-LIB encoding asserts
the constraints (or the negation of the equation) and checks satisfiability, so a
confirmed conflict or equation is `unsat` and a compatibility `sat`. A definite
disagreement is a wrong verdict; a `Timeout` or `GaveUp` is an undecided result.

The reasoners separate cleanly by tier. The order fragment is FOF and is decided by all
four reasoners. The arithmetic fragments are TFF over `$int`, where E (which has no
arithmetic) does not apply: conflicts witnessed by an equality-pinned value or a single
difference constraint are decided by Vampire and the SMT solvers, and the Presburger
sub-cases (divisibility, and the summation of inequalities over a temporal network) only
by Z3 and cvc5.

## Citation

If you use this benchmark, please cite:

> D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, S. Geisler, C. Quix, S. Decker.
> *Sort-Stratified Semantics for ODRL.*

(BibTeX to be added once the proceedings entry is available.)

The TPTP problems are contributed to the TPTP library (Mustafa and Sutcliffe).

## License

See `LICENSE`.