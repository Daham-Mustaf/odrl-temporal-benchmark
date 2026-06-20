"""
problem_data_sequence.py  -- Sequence: ODRL827-830 (Diff tier, andSequence as an STN).
Provider policy = an andSequence of delayPeriod steps (each phase at least g_k after
the previous; delayPeriod gteq is admissible). Consumer policy = an elapsedTime deadline
(the whole sequence within D of the start; elapsedTime lteq is admissible). Conflict iff
the required delays cannot fit the deadline (sum of gaps > D): a negative cycle in the STN.

Points p0 (start) .. p_n; p_k - p_{k-1} >= g_k and p_n - p0 <= D, over $int.
  Conflict   -> ![p..:$int]: ~(ordering & gaps & deadline)  (Theorem)
  Compatible -> ?[p..:$int]:  (ordering & gaps & deadline)   (Theorem)
SMT QF_IDL (difference constraints). Gaps/deadline are day counts.
"""
def _P(pid, name, verdict, descr, gaps, deadline):
    n = len(gaps)
    pts = [f"p{i}" for i in range(n + 1)]
    parts = []
    for k in range(1, n + 1):
        parts.append(f"$lesseq(p{k-1},p{k})")
        parts.append(f"$greatereq($difference(p{k},p{k-1}),{gaps[k-1]})")
    parts.append(f"$lesseq($difference(p{n},p0),{deadline})")
    body = " & ".join(parts)
    qv = ",".join(f"{p}:$int" for p in pts)
    conj = f"?[{qv}]: ({body})" if verdict == "Compatible" else f"![{qv}]: ~({body})"
    decls = "\n".join(f"(declare-const {p} Int)" for p in pts)
    a = []
    for k in range(1, n + 1):
        a.append(f"(assert (<= p{k-1} p{k}))")
        a.append(f"(assert (>= (- p{k} p{k-1}) {gaps[k-1]}))")
    a.append(f"(assert (<= (- p{n} p0) {deadline}))")
    steps = "".join(
        f'\n      [ odrl:leftOperand odrl:delayPeriod ; odrl:operator odrl:gteq ; '
        f'odrl:rightOperand "P{g}D"^^xsd:duration ]' for g in gaps)
    ttl = ("@prefix odrl: <http://www.w3.org/ns/odrl/2/> .\n"
           "@prefix xsd:  <http://www.w3.org/2001/XMLSchema#> .\n"
           "@prefix drk:  <http://w3id.org/drk/ontology/> .\n"
           "# provider: each phase at least the stated delay after the previous\n"
           "drk:policyA a odrl:Set ;\n"
           "  odrl:permission [\n    odrl:action odrl:use ;\n"
           f"    odrl:constraint [\n      odrl:andSequence ({steps}\n      )\n    ]\n  ] .\n"
           "# consumer: the whole sequence must complete within the deadline\n"
           "drk:policyB a odrl:Set ;\n"
           "  odrl:permission [\n    odrl:action odrl:use ;\n"
           "    odrl:constraint [\n      odrl:leftOperand odrl:elapsedTime ;\n"
           f'      odrl:operator odrl:lteq ;\n      odrl:rightOperand "P{deadline}D"^^xsd:duration\n    ]\n  ] .')
    return {
        "id": pid, "subdir": "Sequence", "name": name,
        "relation": "conflict", "verdict": verdict,
        "status_fof": "Theorem", "status_smt": ("sat" if verdict == "Compatible" else "unsat"),
        "difficulty": "Medium", "includes": [], "tptp_lang": "tff", "needs_density": False,
        "description": descr, "ttl": ttl, "fof_extra_decls": "",
        "fof_conjecture": conj,
        "smt2_logic": "QF_IDL", "smt2_decls": decls, "smt2_asserts": "\n".join(a),
    }

PROBLEMS = [
    _P("ODRL827", "delay >= P3D within elapsed deadline P5D -> Compatible", "Compatible",
       ("Provider andSequence with one step delayPeriod gteq P3D (>=3 after start);\n"
        "consumer elapsedTime lteq P5D. 3 <= span <= 5 is satisfiable. Compatible."),
       [3], 5),
    _P("ODRL828", "delay >= P5D within elapsed deadline P3D -> Conflict", "Conflict",
       ("Provider step delayPeriod gteq P5D forces span >= 5; consumer elapsedTime\n"
        "lteq P3D forces span <= 3. 5 <= span <= 3 is a negative cycle. Conflict."),
       [5], 3),
    _P("ODRL829", "delays >= P5D,P5D within deadline P12D -> Compatible", "Compatible",
       ("Provider andSequence delayPeriod gteq P5D then gteq P5D forces span >= 10;\n"
        "consumer elapsedTime lteq P12D. 10 <= 12 fits. Compatible."),
       [5, 5], 12),
    _P("ODRL830", "delays >= P5D,P5D within deadline P8D -> Conflict", "Conflict",
       ("Provider andSequence delayPeriod gteq P5D then gteq P5D forces span >= 10,\n"
        "but consumer elapsedTime lteq P8D forces span <= 8. 10 <= 8: negative cycle. Conflict."),
       [5, 5], 8),
]