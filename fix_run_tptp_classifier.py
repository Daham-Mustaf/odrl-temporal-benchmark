#!/usr/bin/env python3
"""
fix_run_tptp_classifier.py -- run from the root of odrl-temporal-benchmark.

Replaces check_benchmark.py::run_tptp wholesale, so it is safe to run on the
original file or on top of the earlier over-eager "non-zero exit == error"
version.

When a TPTP prover prints no SZS status line there are three distinct causes,
and the original code called all of them "timeout" while the first patch
called all of them "error". Both are wrong:

  error    the prover aborted: malformed input, type error, unsupported syntax
  timeout  the prover hit its time or memory limit  (Vampire exits non-zero here)
  gaveup   the prover terminated on an incomplete strategy without an answer

Idempotent.
"""
import re
import sys
from pathlib import Path

NEW = '''def run_tptp(cmd_builder, path, timeout):
    # .p files may use include('Axioms/...'); run from the problem's directory.
    d, base = os.path.dirname(path), os.path.basename(path)
    try:
        res = subprocess.run(cmd_builder(base, timeout), cwd=d,
                             capture_output=True, text=True, timeout=timeout + 15)
    except subprocess.TimeoutExpired:
        return "timeout"
    out = (res.stdout + res.stderr)
    m = re.search(r"SZS status\\s+(\\w+)", out)
    if m:
        return m.group(1).lower()
    if "Refutation found" in out or "Theorem" in out or "Proof found" in out:
        return "theorem"
    # No SZS line. Separate the three reasons that happens instead of calling
    # them all "timeout": an abort is a defect (in the input or in the prover),
    # a resource limit is a hardness result, and giving up is neither. Order
    # matters: a non-zero exit code alone means nothing, Vampire exits non-zero
    # on a plain time limit.
    if re.search(r"(?i)(type error|type mismatch|parse error|syntax error|"
                 r"variable expected|lexer exception|unsupported|cannot parse)", out):
        return "error"
    if re.search(r"(?i)(time limit|memory limit|resource ?out|resource limit)", out):
        return "timeout"
    if re.search(r"(?i)(refutation not found|incomplete strategy|gave ?up)", out):
        return "gaveup"
    return "error" if res.returncode != 0 else "timeout"
'''


def main():
    path = Path.cwd() / "check_benchmark.py"
    if not path.is_file():
        sys.exit("run this from the root of odrl-temporal-benchmark")

    text = path.read_text(encoding="utf-8")
    if "a resource limit is a hardness result" in text:
        print("ok       run_tptp already carries the corrected classifier")
        return

    # match the whole function, from its def line to the next top-level def
    pat = re.compile(r"^def run_tptp\(.*?(?=^def |\Z)", re.S | re.M)
    if not pat.search(text):
        sys.exit("FAILED   could not locate run_tptp() in check_benchmark.py")

    # lambda replacement: NEW contains backslashes that re.sub would treat as escapes
    path.write_text(pat.sub(lambda _: NEW + "\n\n", text, count=1), encoding="utf-8")
    print("PATCHED  check_benchmark.py::run_tptp (error / timeout / gaveup now distinct)")
    print("\nnow re-run:")
    print("  uv run check_benchmark.py Problems --timeout 20 --csv results.csv")


if __name__ == "__main__":
    main()