# ODRL Temporal Conflict-Detection Benchmark

![Problems](https://img.shields.io/badge/problems-72-success)
![Formats](https://img.shields.io/badge/formats-TPTP%20%2B%20SMT--LIB-informational)
![Vampire](https://img.shields.io/badge/Vampire-5.0.1-1f6feb)
![E](https://img.shields.io/badge/E%20prover-3.3.2-1f6feb)
![Z3](https://img.shields.io/badge/Z3-4.8.12-8957e5)
![cvc5](https://img.shields.io/badge/cvc5-1.3.4-8957e5)
![Python](https://img.shields.io/badge/Python-3.10%2B-3776ab?logo=python&logoColor=white)
![License](https://img.shields.io/badge/license-see%20LICENSE-lightgrey)
[![arXiv](https://img.shields.io/badge/arXiv-2606.23442-b31b1b.svg)](https://arxiv.org/abs/2606.23442)

A benchmark of 72 conflict-detection problems over the temporal operands of ODRL
(`dateTime`, `delayPeriod`, `elapsedTime`, `meteredTime`, `timeInterval`),
accompanying the paper *Sort-Stratified Semantics for ODRL* (Mustafa et al.).
Each problem is emitted in two formats from a single description: a TPTP `.p` file
(for the first-order provers Vampire and E) and an SMT-LIB `.smt2` file (for the SMT
solvers Z3 and cvc5), together with the ODRL policy pair as Turtle (`.ttl`). The two
encodings are separate and are cross-validated against each other and across the
four reasoners.

## Contents

- 72 problems in 15 categories, IDs ODRL800 to ODRL871
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
check_benchmark.py   integrity and reproduction checker (counts, pairing,
               cross-encoding verdict agreement, and an optional four-solver run)
```

## Requirements

- `vampire`, `eprover`, `z3`, and `cvc5` on your `PATH`
- Python 3 (the generators and the checker run under `uv run` or `python3`)

## Running

Run all four reasoners over a category, with a per-problem timeout in seconds, and run
the integrity checker over the whole benchmark:

```bash
bash Generators/run_reasoners.sh Problems/<Category> 20
uv run check_benchmark.py Problems --timeout 20
uv run check_benchmark.py Problems --timeout 20 --csv results.csv
```

Vampire and E are run over the `.p` files, Z3 and cvc5 over the `.smt2` files. Each
reasoner's reported status is checked against the expected status stored in the problem.
`check_benchmark.py` also verifies the structure (72 problems, 15 categories, every
problem paired across `.p`, `.smt2`, and `.ttl`), checks that the verdict recorded in
the two encodings agrees, and, when all four solvers are present, reports per-solver
coverage and flags any answer that disagrees with the declared status.

## Regenerating

```bash
cd odrl-temporal-benchmark
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

The reasoners separate by what each can decide. The order fragment is FOF and is decided
by all four. The arithmetic fragments are TFF over `$int`, which E does not support, so E
decides exactly the 48 order problems. Z3 and cvc5 decide all 72. Vampire decides 62: the
order problems plus the cross-operand, capstone, and runtime conflicts (each a single
difference or equality-pinned bound) and the two periodic-compatible cases (a shared
occurrence it can exhibit). The cases only Z3 and cvc5 decide are the periodic conflicts
(a divisibility argument) and the sequence and network-realizability cases (the
feasibility of a difference system over a whole trace). No solver returns a wrong verdict.

## Citation

If you use this benchmark, please cite:

D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler,
S. Decker, R. Haque. "Sort-Stratified Semantics for Temporal Conflict
Detection in ODRL Policies." arXiv:2606.23442, 2026.
https://arxiv.org/abs/2606.23442

```bibtex
@misc{mustafa2026sortstratifiedsemanticstemporalconflict,
      title={Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies},
      author={Daham M. Mustafa and Diego Collarana and Sabrina Kirrane and Christoph Lange and Christoph Quix and Sandra Geisler and Stefan Decker and Rafiqul Haque},
      year={2026},
      eprint={2606.23442},
      archivePrefix={arXiv},
      primaryClass={cs.LO},
      url={https://arxiv.org/abs/2606.23442},
}
```
The TPTP problems will be contributed to the TPTP library (Mustafa and Sutcliffe).

## License

The code (the generators, `check_benchmark.py`, `main.py`) and the Isabelle/HOL
formalization are licensed under the Apache License 2.0; see [LICENSE](LICENSE)
and [NOTICE](NOTICE).

The benchmark problems under [`Problems/`](Problems/) (the `.p`, `.smt2`, and
`.ttl` files and the bundled axioms) are licensed under
[CC BY 4.0](Problems/LICENSE).

If you use this benchmark, please cite the accompanying paper (see the Citation
section above or [CITATION.cff](CITATION.cff)); citing it satisfies the CC BY
attribution requirement.