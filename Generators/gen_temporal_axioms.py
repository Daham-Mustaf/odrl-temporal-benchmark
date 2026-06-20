"""
gen_temporal_axioms.py  (Temporal Decomposition generator)
==========================================================
Single entry point. Renders every temporal axiom in BOTH formats, TPTP .ax
(via header.AXHeader) and SMT-LIB .smt2 (via header.SMTHeader), from
temporal_axiom_data.AXIOMS.

Usage:  python gen_temporal_axioms.py [output_dir]
Default: <repo>/Problems/ODRL/TemporalDecomposition/Axioms

SMT-LIB has no include mechanism, so the .smt2 files are reference snippets
the problem generator inlines into each problem when needed.
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from header import AXHeader, SMTHeader, _ax_comment
import temporal_axiom_data as data

SEP = "%--------------------------------------------------------------------------\n"


def render_ax(spec):
    body = spec["fof"]
    comments = _ax_comment(body, spec["fof_breakdown"], spec["comments_note"])
    header = AXHeader(
        file     = f"{spec['code']}.ax",
        domain   = "temporal",
        title    = spec["title"],
        version  = "1.0",
        english  = spec["english"],
        refs     = ["temporal2026"],
        comments = comments,
    ).render()
    return header + body + SEP


def render_smt(spec):
    header = SMTHeader(
        file     = f"{spec['code']}.smt2",
        domain   = "temporal",
        title    = spec["smt_title"],
        version  = "1.0",
        refs     = ["temporal2026"],
        comments = spec["smt_comment"],
        status   = "sat",
    ).render()
    return header + spec["smt"]


def main(out_dir: Path):
    out_dir.mkdir(parents=True, exist_ok=True)
    for spec in data.AXIOMS:
        (out_dir / f"{spec['code']}.ax").write_text(render_ax(spec), encoding="utf-8")
        (out_dir / f"{spec['code']}.smt2").write_text(render_smt(spec), encoding="utf-8")
        print(f"  {spec['code']}.ax + {spec['code']}.smt2")
    print(f"\n{len(data.AXIOMS)} axiom families written to {out_dir}")


if __name__ == "__main__":
    default = Path(__file__).resolve().parents[2] / "Problems/ODRL/TemporalDecomposition/Axioms"
    main(Path(sys.argv[1]) if len(sys.argv) > 1 else default)