#!/usr/bin/env python3
"""
fix_tptp_conformance.py -- run from the root of odrl-temporal-benchmark.

Three source-level fixes, then regenerate:

  1. Generators/problem_data_sequence.py
     TPTP variables must be upper_word. The Sequence generator reused the
     SMT-LIB constant names (p0, p1, ...) as TPTP quantified variables, so
     ODRL827-830 were not valid TPTP and no TPTP prover ever parsed them.

  2. Generators/writers.py
     The separator comments use U+2500 box drawing. TPTP library files are
     ASCII; tptp4X will flag every one of the 72 problems.

  3. check_benchmark.py
     run_tptp() returns "timeout" whenever no SZS line is found, which is
     exactly what a prover abort produces. Distinguish "error" from "timeout".

Idempotent: already-applied fixes are reported as "ok" and skipped.
"""
import sys
from pathlib import Path

CHANGES = [
    (
        "Generators/problem_data_sequence.py",
        # marker that tells us the fix is already in place
        'var = [f"P{i}"',
        # old
        '''    n = len(gaps)
    pts = [f"p{i}" for i in range(n + 1)]
    parts = []
    for k in range(1, n + 1):
        parts.append(f"$lesseq(p{k-1},p{k})")
        parts.append(f"$greatereq($difference(p{k},p{k-1}),{gaps[k-1]})")
    parts.append(f"$lesseq($difference(p{n},p0),{deadline})")
    body = " & ".join(parts)
    qv = ",".join(f"{p}:$int" for p in pts)''',
        # new
        '''    n = len(gaps)
    pts = [f"p{i}" for i in range(n + 1)]        # SMT-LIB constants: lower case
    var = [f"P{i}" for i in range(n + 1)]        # TPTP variables: must be upper_word
    parts = []
    for k in range(1, n + 1):
        parts.append(f"$lesseq({var[k-1]},{var[k]})")
        parts.append(f"$greatereq($difference({var[k]},{var[k-1]}),{gaps[k-1]})")
    parts.append(f"$lesseq($difference({var[n]},{var[0]}),{deadline})")
    body = " & ".join(parts)
    qv = ",".join(f"{v}:$int" for v in var)''',
    ),
    (
        "Generators/writers.py",
        '"%---- Conjecture "',
        'conjecture_header = "% \\u2500\\u2500\\u2500 Conjecture " + "\\u2500" * 52 + "\\n"',
        'conjecture_header = "%---- Conjecture " + "-" * 52 + "\\n"',
    ),
    (
        "Generators/writers.py",
        '"%---- Named constants and ordering "',
        '+ "% \\u2500\\u2500\\u2500 Named constants and ordering " + "\\u2500" * 37 + "\\n"',
        '+ "%---- Named constants and ordering " + "-" * 37 + "\\n"',
    ),
    (
        "check_benchmark.py",
        "hides both malformed input and prover bugs",
        '''    if "Refutation found" in out or "Theorem" in out or "Proof found" in out:
        return "theorem"
    return "timeout"''',
        '''    if "Refutation found" in out or "Theorem" in out or "Proof found" in out:
        return "theorem"
    # A prover that aborts (type error, syntax error, unsupported feature) exits
    # non-zero and prints no SZS line. That is not a timeout, and recording it as
    # one hides both malformed input and prover bugs. Checked after the SZS regex,
    # so a genuine resource-out (E exits 9 with "SZS status ResourceOut") is safe.
    if res.returncode != 0 or re.search(r"(?i)\\b(type error|syntax error|parse error)\\b", out):
        return "error"
    return "timeout"''',
    ),
]


def main():
    root = Path.cwd()
    if not (root / "Generators").is_dir():
        sys.exit("run this from the root of odrl-temporal-benchmark")

    failed = False
    for rel, marker, old, new in CHANGES:
        path = root / rel
        if not path.is_file():
            print(f"MISSING  {rel}")
            failed = True
            continue
        text = path.read_text(encoding="utf-8")
        label = f"{rel}: {new.strip().splitlines()[0][:46]}"
        if marker in text:
            print(f"ok       {label} (already applied)")
            continue
        if old not in text:
            print(f"FAILED   {label} (anchor text not found)")
            failed = True
            continue
        path.write_text(text.replace(old, new, 1), encoding="utf-8")
        print(f"PATCHED  {label}")

    if failed:
        sys.exit("\nsome edits did not apply, nothing regenerated")

    print("\nnow run:")
    print("  uv run Generators/gen_problems.py Problems")
    print("  uv run check_benchmark.py Problems --timeout 20 --csv results.csv")


if __name__ == "__main__":
    main()