#!/usr/bin/env python3
"""
check_benchmark.py - integrity and reproduction checker for the ODRL temporal
conflict-detection benchmark.

It verifies the claims the paper's Evaluation section makes, without you having
to trust them by eye:

  STRUCTURE
    - total number of problems and unique ODRL ids
    - number of categories
    - every problem has a .p (TPTP), a .smt2 (SMT-LIB) and a policy .ttl
    - per-category counts, summed

  METADATA
    - the verdict recorded in the .p header matches the one in the .smt2 header
    - the expected SZS / sat-unsat status is reconciled against the verdict
    - FOF vs TFF split on the TPTP side (should equal Order vs arithmetic rows)
    - SMT-LIB set-logic distribution

  SOLVERS (only for solvers found on PATH: z3, cvc5, vampire, eprover)
    - run each solver on each problem under a timeout
    - flag any answer that DISAGREES with the file's declared status (a real bug)
    - report, per solver, how many problems it decides
    - partition the problems into:
        all four decide           -> "Order" row
        vampire + SMT decide      -> "Arithmetic (witness)" row
        only z3 + cvc5 decide     -> "Arithmetic (model/Presburger)" row
      and print the sizes so you can compare to the table (48 / 13 / 10).

Usage:
    python3 check_benchmark.py /path/to/Problems
    python3 check_benchmark.py /path/to/Problems --timeout 20
    python3 check_benchmark.py /path/to/Problems --no-solvers   # metadata only
    python3 check_benchmark.py /path/to/Problems --expect-total 71 --expect-categories 15

Exit code is non-zero if any check fails (missing files, verdict mismatch,
wrong solver answer, or a count that differs from --expect-*).
"""
import argparse
import os
import re
import shutil
import subprocess
import sys
from collections import defaultdict

NON_CATEGORY_DIRS = {"Axioms", "Policies"}
PROVED = {"theorem", "unsatisfiable", "contradictoryaxioms"}     # TPTP: conjecture holds
DISPROVED = {"countersatisfiable", "satisfiable", "countersatisfiable"}  # TPTP: conjecture refuted

# ----------------------------------------------------------------------------- header parsing
def parse_p_header(path):
    verdict = status = None
    lang = None  # 'fof' or 'tff'
    with open(path, encoding="utf-8", errors="replace") as fh:
        for line in fh:
            m = re.match(r"^%\s*Verdict\s*:\s*(\S+)", line)
            if m and verdict is None:
                verdict = m.group(1)
            m = re.match(r"^%\s*Status\s*:\s*(\S+)", line)
            if m and status is None:
                status = m.group(1)
            if lang is None:
                if re.match(r"^\s*tff\(", line):
                    lang = "tff"
                elif re.match(r"^\s*(fof|cnf)\(", line):
                    lang = "fof"
    return verdict, status, lang


def parse_smt_header(path):
    verdict = status = logic = None
    with open(path, encoding="utf-8", errors="replace") as fh:
        for line in fh:
            m = re.match(r"^;\s*Status\s*:\s*(\S+)", line)
            if m and status is None:
                status = m.group(1).lower()
            m = re.search(r"Verdict\s*:\s*(\w+)", line)
            if m and verdict is None and line.lstrip().startswith(";"):
                verdict = m.group(1)
            m = re.search(r"\(set-logic\s+(\S+?)\)", line)
            if m and logic is None:
                logic = m.group(1)
    return verdict, status, logic


# ----------------------------------------------------------------------------- discovery
def discover(problems_dir):
    """Return {category: {id: {'p':path,'smt2':path}}} and policy id set."""
    cats = defaultdict(dict)
    for entry in sorted(os.listdir(problems_dir)):
        full = os.path.join(problems_dir, entry)
        if not os.path.isdir(full) or entry in NON_CATEGORY_DIRS:
            continue
        for fn in os.listdir(full):
            m = re.match(r"(ODRL\d+)-\d+\.(p|smt2)$", fn)
            if not m:
                continue
            pid, ext = m.group(1), m.group(2)
            cats[entry].setdefault(pid, {})[ext] = os.path.join(full, fn)
    policies = set()
    pol_dir = os.path.join(problems_dir, "Policies")
    if os.path.isdir(pol_dir):
        for fn in os.listdir(pol_dir):
            m = re.match(r"(ODRL\d+)-", fn)
            if m:
                policies.add(m.group(1))
    return cats, policies


# ----------------------------------------------------------------------------- solver runners
def run_z3(path, timeout):
    try:
        out = subprocess.run(["z3", f"-T:{timeout}", path],
                             capture_output=True, text=True,
                             timeout=timeout + 10).stdout.lower()
    except subprocess.TimeoutExpired:
        return "timeout"
    for tok in ("unsat", "sat", "unknown", "timeout"):
        if tok in out:
            return tok
    return "error"


def run_cvc5(path, timeout):
    try:
        out = subprocess.run(["cvc5", f"--tlimit={timeout*1000}", path],
                             capture_output=True, text=True,
                             timeout=timeout + 10).stdout.lower()
    except subprocess.TimeoutExpired:
        return "timeout"
    for tok in ("unsat", "sat", "unknown"):
        if tok in out:
            return tok
    return "error"


def run_tptp(cmd_builder, path, timeout):
    # .p files use include('Axioms/...'); run from the problem's directory.
    d, base = os.path.dirname(path), os.path.basename(path)
    try:
        res = subprocess.run(cmd_builder(base, timeout), cwd=d,
                             capture_output=True, text=True, timeout=timeout + 15)
    except subprocess.TimeoutExpired:
        return "timeout"
    out = (res.stdout + res.stderr)
    m = re.search(r"SZS status\s+(\w+)", out)
    if m:
        return m.group(1).lower()
    if "Refutation found" in out or "Theorem" in out:
        return "theorem"
    return "timeout"


def vampire_cmd(base, t):
    return ["vampire", "-t", f"{t}s", base]


def eprover_cmd(base, t):
    return ["eprover", "--auto", "--tptp3-format", "-s",
            f"--soft-cpu-limit={t}", base]


def smt_correct(declared, result):
    if result in ("sat", "unsat"):
        return ("ok" if result == declared else "WRONG")
    return "undecided"


def tptp_correct(declared, result):
    # declared is typically 'theorem'
    if result in PROVED:
        return "ok"
    if result in DISPROVED:
        return "WRONG"
    return "undecided"


# ----------------------------------------------------------------------------- main
def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("problems_dir")
    ap.add_argument("--timeout", type=int, default=20)
    ap.add_argument("--no-solvers", action="store_true")
    ap.add_argument("--expect-total", type=int, default=71)
    ap.add_argument("--expect-categories", type=int, default=15)
    args = ap.parse_args()

    if not os.path.isdir(args.problems_dir):
        sys.exit(f"not a directory: {args.problems_dir}")

    failures = []
    cats, policies = discover(args.problems_dir)

    # ---- STRUCTURE -----------------------------------------------------------
    print("=" * 70)
    print("STRUCTURE")
    print("=" * 70)
    all_ids = sorted({pid for cat in cats.values() for pid in cat})
    total = len(all_ids)
    print(f"categories : {len(cats)}  (expected {args.expect_categories})")
    print(f"problems   : {total}  (expected {args.expect_total})")
    if len(cats) != args.expect_categories:
        failures.append(f"category count {len(cats)} != {args.expect_categories}")
    if total != args.expect_total:
        failures.append(f"problem count {total} != {args.expect_total}")

    print("\nper category (id count):")
    running = 0
    for cat in sorted(cats):
        n = len(cats[cat])
        running += n
        print(f"  {cat:<20} {n}")
    print(f"  {'SUM':<20} {running}")
    if running != total:
        failures.append(f"per-category sum {running} != unique ids {total}")

    # pairing: every id has .p, .smt2, .ttl
    missing = []
    for cat in cats:
        for pid, files in cats[cat].items():
            if "p" not in files:
                missing.append(f"{pid} ({cat}) missing .p")
            if "smt2" not in files:
                missing.append(f"{pid} ({cat}) missing .smt2")
            if pid not in policies:
                missing.append(f"{pid} ({cat}) missing policy .ttl")
    print(f"\npairing: {'all problems have .p + .smt2 + .ttl' if not missing else str(len(missing)) + ' problems incomplete'}")
    for m in missing[:20]:
        print("  -", m)
    failures.extend(missing)

    # ---- METADATA ------------------------------------------------------------
    print("\n" + "=" * 70)
    print("METADATA")
    print("=" * 70)
    verdict_dist = defaultdict(int)
    smt_status_dist = defaultdict(int)
    p_status_dist = defaultdict(int)
    logic_dist = defaultdict(int)
    lang_dist = defaultdict(int)
    verdict_mismatch = []
    status_x_verdict = defaultdict(lambda: defaultdict(int))
    meta = {}  # pid -> dict

    for cat in cats:
        for pid, files in cats[cat].items():
            vp = sp = lang = vs = ss = logic = None
            if "p" in files:
                vp, sp, lang = parse_p_header(files["p"])
                lang_dist[lang or "?"] += 1
                p_status_dist[sp or "?"] += 1
            if "smt2" in files:
                vs, ss, logic = parse_smt_header(files["smt2"])
                smt_status_dist[ss or "?"] += 1
                logic_dist[logic or "?"] += 1
            verdict = vp or vs
            verdict_dist[verdict or "?"] += 1
            if vp and vs and vp != vs:
                verdict_mismatch.append(f"{pid}: p={vp} smt2={vs}")
            if verdict and ss:
                status_x_verdict[verdict][ss] += 1
            meta[pid] = dict(cat=cat, verdict=verdict, p_status=sp, smt_status=ss,
                             lang=lang, logic=logic,
                             p=files.get("p"), smt2=files.get("smt2"))

    print("verdict distribution :", dict(sorted(verdict_dist.items())))
    print("TPTP language split  :", dict(sorted(lang_dist.items())),
          "  <- fof should equal the Order row, tff the arithmetic rows")
    print("TPTP status (SZS)    :", dict(sorted(p_status_dist.items())))
    print("SMT status           :", dict(sorted(smt_status_dist.items())))
    print("SMT set-logic        :", dict(sorted(logic_dist.items())))

    print(f"\nverdict agreement (.p vs .smt2): "
          f"{'all match' if not verdict_mismatch else str(len(verdict_mismatch)) + ' MISMATCHES'}")
    for m in verdict_mismatch[:20]:
        print("  -", m)
    failures.extend(verdict_mismatch)

    print("\nexpected SMT status by verdict (sanity):")
    for v in sorted(status_x_verdict):
        print(f"  {v:<14} {dict(sorted(status_x_verdict[v].items()))}")

    # ---- SOLVERS -------------------------------------------------------------
    if not args.no_solvers:
        print("\n" + "=" * 70)
        print(f"SOLVERS  (timeout {args.timeout}s)")
        print("=" * 70)
        have = {name: shutil.which(name) for name in ("z3", "cvc5", "vampire", "eprover")}
        print("found on PATH:", {k: bool(v) for k, v in have.items()})

        # per-pid per-solver result class: 'ok' / 'WRONG' / 'undecided' / 'absent'
        decided = defaultdict(set)   # solver -> set of pids it decided correctly
        wrong = []                   # (pid, solver, declared, result)
        any_solver = any(have.values())

        for pid in all_ids:
            m = meta[pid]
            # SMT solvers
            for name, runner in (("z3", run_z3), ("cvc5", run_cvc5)):
                if have[name] and m["smt2"] and m["smt_status"] in ("sat", "unsat"):
                    r = runner(m["smt2"], args.timeout)
                    verdict_ok = smt_correct(m["smt_status"], r)
                    if verdict_ok == "ok":
                        decided[name].add(pid)
                    elif verdict_ok == "WRONG":
                        wrong.append((pid, name, m["smt_status"], r))
            # TPTP solvers
            for name, builder in (("vampire", vampire_cmd), ("eprover", eprover_cmd)):
                if have[name] and m["p"]:
                    r = run_tptp(builder, m["p"], args.timeout)
                    verdict_ok = tptp_correct((m["p_status"] or "theorem").lower(), r)
                    if verdict_ok == "ok":
                        decided[name].add(pid)
                    elif verdict_ok == "WRONG":
                        wrong.append((pid, name, m["p_status"], r))

        if any_solver:
            print("\ndecided (correctly) per solver:")
            for name in ("vampire", "eprover", "z3", "cvc5"):
                if have[name]:
                    print(f"  {name:<8} {len(decided[name])} / {total}")

            print(f"\nWRONG answers (result disagrees with declared status): {len(wrong)}")
            for pid, name, decl, res in wrong[:40]:
                print(f"  - {pid} {name}: declared {decl}, got {res}")
            failures.extend(f"{pid} {name} wrong ({decl}->{res})" for pid, name, decl, res in wrong)

            # tier partition by prover capability (only meaningful with all 4)
            if all(have[n] for n in ("vampire", "eprover", "z3", "cvc5")):
                order, witness, presb, other = [], [], [], []
                for pid in all_ids:
                    d = {n for n in ("vampire", "eprover", "z3", "cvc5") if pid in decided[n]}
                    if d == {"vampire", "eprover", "z3", "cvc5"}:
                        order.append(pid)
                    elif d == {"vampire", "z3", "cvc5"}:
                        witness.append(pid)
                    elif d == {"z3", "cvc5"}:
                        presb.append(pid)
                    else:
                        other.append((pid, sorted(d)))
                print("\ntier partition by who decides (compare to table 48 / 13 / 10):")
                print(f"  all four decide            (Order)               : {len(order)}")
                print(f"  vampire+z3+cvc5, not E     (Arithmetic, witness)  : {len(witness)}")
                for p in witness:
                    print(f"      {p}  {meta[p]['cat']}")
                print(f"  only z3+cvc5               (Arithmetic, model)    : {len(presb)}")
                for p in presb:
                    print(f"      {p}  {meta[p]['cat']}")
                if other:
                    print(f"  OTHER pattern (unexpected)                       : {len(other)}")
                    for p, d in other:
                        print(f"      {p}  {meta[p]['cat']}  decided-by={d}")
        else:
            print("no solvers on PATH; skipping the run "
                  "(install z3/cvc5/vampire/eprover or use --no-solvers)")

    # ---- SUMMARY -------------------------------------------------------------
    print("\n" + "=" * 70)
    if failures:
        print(f"RESULT: {len(failures)} problem(s) found")
        for f in failures[:60]:
            print("  -", f)
        sys.exit(1)
    print("RESULT: all checks passed")


if __name__ == "__main__":
    main()