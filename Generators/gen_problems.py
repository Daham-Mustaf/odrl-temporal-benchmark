"""
gen_problems.py  (Temporal Decomposition generator)
===================================================
Driver: renders every problem_data_*.PROBLEMS into .p + .smt2 (+ policy .ttl).
Usage:  python3 gen_problems.py [output_dir]
Default: <repo>/Problems/ODRL/TemporalDecomposition
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from writers import write_fof_problem, write_smt2_problem, write_ttl_policy







import problem_data_single
import problem_data_periodic
import problem_data_cross
import problem_data_capstone
import problem_data_sequence
import problem_data_conflictcriterion
import problem_data_runtime
import problem_data_logical
import problem_data_refinement
import problem_data_unknown
import problem_data_completion
import problem_data_composition
import problem_data_realizability
import problem_data_sortablation

MODULES = [
    problem_data_single,
    problem_data_periodic,
    problem_data_cross,
    problem_data_capstone,
    problem_data_sequence,
    problem_data_conflictcriterion,
    problem_data_runtime,
    problem_data_logical,
    problem_data_refinement,
    problem_data_unknown,
    problem_data_completion,
    problem_data_composition,
    problem_data_realizability,
    problem_data_sortablation,
]   # add problem_data_criterion, ... here


def main(out_root: Path):
    pol = out_root / "Policies"
    subdirs, n = set(), 0
    for mod in MODULES:
        for p in mod.PROBLEMS: 
            pp = write_fof_problem(p, out_root)
            ps = write_smt2_problem(p, out_root)
            write_ttl_policy(p, pol)
            subdirs.add(p["subdir"])
            tag = pp.name + (" + " + ps.name if ps else "")
            print(f"  {p['id']:<8} {p['verdict']:<11} {tag}")
            n += 1
    # Symlink Axioms/ -> ../Axioms into each category so include('Axioms/..') resolves
    for sd in sorted(subdirs):
        link = out_root / sd / "Axioms"
        if not link.exists():
            try:
                link.symlink_to(Path("../Axioms"), target_is_directory=True)
                print(f"  symlink   {sd}/Axioms -> ../Axioms")
            except OSError as e:
                print(f"  (symlink {sd}/Axioms skipped: {e})")
    print(f"\n{n} problems -> {out_root}")


if __name__ == "__main__":
    base = Path(__file__).resolve().parents[2] / "Problems/ODRL/TemporalDecomposition"
    main(Path(sys.argv[1]) if len(sys.argv) > 1 else base)
