#!/usr/bin/env python3
"""Validate the benchmark's Turtle policies against its SHACL profile."""

from argparse import ArgumentParser
from pathlib import Path

from pyshacl import validate
from rdflib import Graph


ROOT = Path(__file__).resolve().parent
DEFAULT_POLICIES = ROOT / "Problems" / "Policies"
DEFAULT_SHAPES = ROOT / "shacl" / "odrl-temporal.shapes.ttl"
DEFAULT_ONTOLOGY = ROOT / "ontology" / "drk-temporal-extension.ttl"


def main() -> int:
    parser = ArgumentParser(description=__doc__)
    parser.add_argument("policies", nargs="?", type=Path, default=DEFAULT_POLICIES)
    parser.add_argument("--shapes", type=Path, default=DEFAULT_SHAPES)
    parser.add_argument("--ontology", type=Path, default=DEFAULT_ONTOLOGY)
    args = parser.parse_args()

    files = sorted(args.policies.glob("*.ttl"))
    if not files:
        parser.error(f"no .ttl policies found in {args.policies}")

    # Parsing text avoids rdflib treating Windows UNC paths as malformed file URLs.
    shapes = Graph().parse(data=args.shapes.read_text(encoding="utf-8"), format="turtle")
    ontology = Graph().parse(data=args.ontology.read_text(encoding="utf-8"), format="turtle")
    failures = 0
    for policy in files:
        try:
            data = Graph().parse(data=policy.read_text(encoding="utf-8"), format="turtle")
            conforms, _, report = validate(
                data_graph=data,
                shacl_graph=shapes,
                ont_graph=ontology,
                advanced=True,
                allow_warnings=False,
            )
        except Exception as exc:
            failures += 1
            print(f"FAIL {policy.name}: RDF/SHACL error: {exc}")
            continue
        if conforms:
            print(f"PASS {policy.name}")
        else:
            failures += 1
            print(f"FAIL {policy.name}\n{report.strip()}")

    print(f"\nValidated {len(files)} policies: {len(files) - failures} passed, {failures} failed")
    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
