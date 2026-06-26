#!/usr/bin/env python3
"""
scan_odrl_coverage.py

Scan an ODRL benchmark repo (or several) and report which ODRL components are
actually exercised, so the paper's scope claims rest on counts rather than memory.

The .ttl policy files are the source of truth: they carry the real ODRL terms
verbatim (odrl:lt, odrl:isPartOf, odrl:dateTime). The .p / .smt2 files transform
these into prover syntax, so coverage there is ambiguous; this script reports
.ttl coverage as authoritative and gives an optional .p/.smt2 cross-check.

Usage:
    python3 scan_odrl_coverage.py PATH [PATH ...]
    python3 scan_odrl_coverage.py Problems
    python3 scan_odrl_coverage.py ~/projects/odrl-temporal-benchmark \
                                  ~/projects/ODRL-Axis-Aligned-Profile-OAAP \
                                  ~/projects/odrl-kgc-benchmark
    python3 scan_odrl_coverage.py Problems --by-category --missing --csv coverage.csv

No third-party deps; stdlib only. Matching is case-insensitive and tolerant of
prefixes (odrl:lt, :lt, http://www.w3.org/ns/odrl/2/lt) and of camelCase tokens
appearing in comments or identifiers in the .p/.smt2 files.
"""
import argparse
import csv
import os
import re
import sys
from collections import defaultdict

# ---- The ODRL vocabulary we care about (the full inventory, so we can report
#      what is MISSING as well as what is present). ----
COMPARISON = ["eq", "neq", "lt", "lteq", "gt", "gteq"]
MEMBERSHIP = ["isA", "hasPart", "isPartOf", "isAllOf", "isAnyOf", "isNoneOf"]
LOGICAL    = ["and", "or", "xone", "andSequence"]

# Common ODRL leftOperands (temporal, spatial, and general). Extend freely.
LEFT_OPERANDS = [
    # temporal
    "dateTime", "delayPeriod", "elapsedTime", "meteredTime", "timeInterval",
    # counting / numeric
    "count", "payAmount", "percentage", "fileFormat", "resolution",
    # spatial
    "spatial", "spatialCoordinates", "absoluteSize", "absoluteSpatialPosition",
    "relativeSize", "relativeSpatialPosition", "latitude", "longitude",
    # general / knowledge-base
    "purpose", "recipient", "industry", "language", "media",
    "systemDevice", "virtualLocation", "version", "product",
    "event", "deliveryChannel", "unitOfCount",
]

# Operators that are NOT a real ODRL leftOperand but show up as ODRL terms worth
# noting if present (action-level, not constraint-level). Reported separately.
ACTIONS_OF_INTEREST = [
    "use", "distribute", "sell", "give", "share", "reproduce", "modify",
    "derive", "grantUse", "nextPolicy", "compensate", "obtainConsent",
]

ALL_OPERATORS = COMPARISON + MEMBERSHIP + LOGICAL


def _word_regex(term):
    """Case-insensitive matcher for an ODRL term that may appear as
    odrl:term, :term, .../odrl/2/term, "term", or as a bare camelCase token.
    Uses a boundary that treats ':' '/' '"' '#' and word edges as delimiters,
    so 'lt' does NOT match inside 'default' or 'result'."""
    # left boundary: start, or one of : / " # space ( [ , or non-word
    # right boundary: end, or one of : / " # space ) ] , . or non-word
    # We additionally anchor on a preceding ':' or '/' or quote OR a word
    # boundary, then the exact term, then a non-letter.
    esc = re.escape(term)
    # (?<![A-Za-z0-9_]) prevents matching inside a longer alnum run on the left;
    # (?![A-Za-z0-9_]) on the right. This keeps camelCase whole-token matches
    # (andSequence won't match 'and') because 'andSequence' has letters after 'and'.
    return re.compile(r"(?<![A-Za-z0-9_])" + esc + r"(?![A-Za-z0-9_])")


# Precompile
_RE = {t: _word_regex(t) for t in ALL_OPERATORS + LEFT_OPERANDS + ACTIONS_OF_INTEREST}


def family_of(path):
    """Best-effort family label from the path. Adjust to your layout."""
    p = path.lower()
    if "temporal" in p:
        return "temporal"
    if "axis" in p or "spatial" in p or "oaap" in p:
        return "spatial"
    if "kgc" in p or "knowledge" in p or "grounded" in p or "kg-" in p:
        return "kgc"
    return os.path.basename(os.path.dirname(path)) or "unknown"


def category_of(path):
    """The immediate parent directory name, your per-category folder."""
    return os.path.basename(os.path.dirname(path))


def scan_file(path, present):
    """Record which terms appear in one file. present is a set we add to."""
    try:
        text = open(path, encoding="utf-8", errors="replace").read()
    except OSError:
        return set()
    hits = set()
    for term, rx in _RE.items():
        if rx.search(text):
            hits.add(term)
            present.add(term)
    return hits


def main():
    ap = argparse.ArgumentParser(description="Scan ODRL component coverage in a benchmark.")
    ap.add_argument("paths", nargs="+", help="Repo or Problems directories to scan.")
    ap.add_argument("--ext", default="ttl",
                    help="Comma-separated extensions to treat as source of truth "
                         "(default: ttl). Use 'ttl,p,smt2' to also cross-check encodings.")
    ap.add_argument("--by-category", action="store_true",
                    help="Also break coverage down per category directory.")
    ap.add_argument("--by-family", action="store_true",
                    help="Break coverage down per family (temporal/spatial/kgc).")
    ap.add_argument("--missing", action="store_true",
                    help="List ODRL operators/operands NOT found (the scope boundary).")
    ap.add_argument("--csv", help="Write a per-term, per-file presence matrix to CSV.")
    args = ap.parse_args()

    exts = tuple("." + e.lstrip(".") for e in args.ext.split(","))

    files = []
    for root in args.paths:
        if os.path.isfile(root) and root.endswith(exts):
            files.append(root)
            continue
        for dirpath, _dirs, names in os.walk(root):
            for n in names:
                if n.endswith(exts):
                    files.append(os.path.join(dirpath, n))
    files.sort()
    if not files:
        print(f"No files with extensions {exts} under {args.paths}", file=sys.stderr)
        sys.exit(1)

    present_global = set()
    per_family = defaultdict(set)            # family -> set(terms)
    per_category = defaultdict(set)          # category -> set(terms)
    per_family_files = defaultdict(int)
    rows = []                                # for CSV: (file, family, category, term)

    for f in files:
        fam = family_of(f)
        cat = category_of(f)
        per_family_files[fam] += 1
        hits = scan_file(f, present_global)
        per_family[fam] |= hits
        per_category[cat] |= hits
        if args.csv:
            for t in sorted(hits):
                rows.append((f, fam, cat, t))

    def report_group(title, terms, present):
        covered = [t for t in terms if t in present]
        missing = [t for t in terms if t not in present]
        print(f"  {title}:")
        print(f"    covered ({len(covered)}/{len(terms)}): "
              + (", ".join(covered) if covered else "(none)"))
        if args.missing and missing:
            print(f"    MISSING: {', '.join(missing)}")

    print(f"\nScanned {len(files)} file(s) with extensions {exts}.\n")
    print("=" * 64)
    print("OVERALL ODRL COMPONENT COVERAGE (source of truth: " + args.ext + ")")
    print("=" * 64)
    report_group("Comparison operators", COMPARISON, present_global)
    report_group("Set / membership operators", MEMBERSHIP, present_global)
    report_group("Logical connectives", LOGICAL, present_global)
    report_group("Left operands", LEFT_OPERANDS, present_global)
    # actions are informational only
    acts = [a for a in ACTIONS_OF_INTEREST if a in present_global]
    if acts:
        print(f"  Actions present (informational): {', '.join(acts)}")

    if args.by_family:
        print("\n" + "=" * 64)
        print("PER-FAMILY COVERAGE")
        print("=" * 64)
        for fam in sorted(per_family):
            print(f"\n[{fam}]  ({per_family_files[fam]} files)")
            report_group("  comparison", COMPARISON, per_family[fam])
            report_group("  membership", MEMBERSHIP, per_family[fam])
            report_group("  logical", LOGICAL, per_family[fam])
            ops = [o for o in LEFT_OPERANDS if o in per_family[fam]]
            print(f"    operands: {', '.join(ops) if ops else '(none)'}")

    if args.by_category:
        print("\n" + "=" * 64)
        print("PER-CATEGORY OPERATOR/CONNECTIVE COVERAGE")
        print("=" * 64)
        for cat in sorted(per_category):
            ops = [o for o in ALL_OPERATORS if o in per_category[cat]]
            lops = [o for o in LEFT_OPERANDS if o in per_category[cat]]
            print(f"  {cat}:")
            print(f"    operators: {', '.join(ops) if ops else '(none)'}")
            print(f"    operands:  {', '.join(lops) if lops else '(none)'}")

    if args.csv:
        with open(args.csv, "w", newline="", encoding="utf-8") as fh:
            w = csv.writer(fh)
            w.writerow(["file", "family", "category", "odrl_term"])
            w.writerows(rows)
        print(f"\nWrote per-file presence matrix: {args.csv} ({len(rows)} rows)")

    # A compact scope line you can paste into the paper / README.
    print("\n" + "-" * 64)
    print("SCOPE LINE (paste-ready):")
    cmp_c = [t for t in COMPARISON if t in present_global]
    mem_c = [t for t in MEMBERSHIP if t in present_global]
    log_c = [t for t in LOGICAL if t in present_global]
    print(f"  comparison: {', '.join(cmp_c) or 'none'}")
    print(f"  membership: {', '.join(mem_c) or 'none'}")
    print(f"  logical:    {', '.join(log_c) or 'none'}")
    print("-" * 64)


if __name__ == "__main__":
    main()