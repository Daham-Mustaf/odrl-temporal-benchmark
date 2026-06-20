"""Runtime ODRL837-842: ground evaluation. Operand value computed in Python; the TPTP
conjecture is a ground arithmetic check over literals (no quantifiers, no var=term, which
makes Vampire loop). SMT keeps context vars + inline computation. Admissible operators."""
OPT = {"lteq": "$lesseq", "gteq": "$greatereq", "lt": "$less", "gt": "$greater", "eq": "="}
OPS = {"lteq": "<=", "gteq": ">=", "lt": "<", "gt": ">", "eq": "="}
OPER = {"elapsed": "elapsedTime", "metered": "meteredTime", "delay": "delayPeriod"}

def elapsed(c): return (c["now"] - c["start"], "(- now start)")
def delay(c):   return (c["now"] - c["trig"],  "(- now trig)")
def metered(c):
    s = sorted(int(k[1:]) for k in c if len(k) > 1 and k[0] == "s" and k[1:].isdigit())
    t = [f"(- e{i} s{i})" for i in s]
    return (sum(c[f"e{i}"] - c[f"s{i}"] for i in s), t[0] if len(t) == 1 else "(+ " + " ".join(t) + ")")

COMPF = {"elapsed": elapsed, "metered": metered, "delay": delay}

def _ttl(policies, note):
    B = []
    for pn, cons in policies:
        if len(cons) == 1:
            n, op, v = cons[0]
            c = f'    odrl:constraint [ odrl:leftOperand odrl:{OPER[n]} ; odrl:operator odrl:{op} ; odrl:rightOperand "P{v}D"^^xsd:duration ]'
        else:
            inner = "".join(f'\n      [ odrl:leftOperand odrl:{OPER[n]} ; odrl:operator odrl:{op} ; odrl:rightOperand "P{v}D"^^xsd:duration ]' for n, op, v in cons)
            c = f"    odrl:constraint [\n      odrl:and ({inner}\n      )\n    ]"
        B.append(f"drk:{pn} a odrl:Set ;\n  odrl:permission [ odrl:action odrl:use ;\n{c} ] .")
    return ("@prefix odrl: <http://www.w3.org/ns/odrl/2/> .\n@prefix xsd:  <http://www.w3.org/2001/XMLSchema#> .\n@prefix drk:  <http://w3id.org/drk/ontology/> .\n" + f"# Ground execution: {note}\n" + "\n".join(B))

def P(pid, name, verdict, descr, note, ctx, ops, bounds, policies):
    comp = {o: COMPF[o](ctx) for o in ops}
    ta, sb = [], []
    for o, op, v in bounds:
        val, expr = comp[o]
        ta.append(f"{val} = {v}" if op == "eq" else f"{OPT[op]}({val}, {v})")
        sb.append(f"(assert ({OPS[op]} {expr} {v}))")
    body = " & ".join(ta)
    conj = f"({body})" if verdict == "Compatible" else f"~({body})"
    decls = "\n".join(f"(declare-const {k} Int)" for k in ctx)
    a = [f"(assert (= {k} {val}))" for k, val in ctx.items()] + sb
    return {"id": pid, "subdir": "Runtime", "name": name, "relation": "runtime", "verdict": verdict,
            "status_fof": "Theorem", "status_smt": ("sat" if verdict == "Compatible" else "unsat"),
            "difficulty": "Easy", "includes": [], "tptp_lang": "tff", "needs_density": False,
            "description": descr, "ttl": _ttl(policies, note), "fof_extra_decls": "",
            "fof_conjecture": conj, "smt2_logic": "QF_LIA", "smt2_decls": decls, "smt2_asserts": "\n".join(a)}

PROBLEMS = [
    P("ODRL837", "compliant execution (elapsed 8, metered 5) -> Compatible", "Compatible",
      "elapsed=now-start=8<=10 and metered=2+3=5<=5: execution complies. Compatible.",
      "start=0, now=8, segments [0,2],[4,7]",
      {"start": 0, "now": 8, "s1": 0, "e1": 2, "s2": 4, "e2": 7}, ["elapsed", "metered"],
      [("elapsed", "lteq", 10), ("metered", "lteq", 5)],
      [("policy", [("elapsed", "lteq", 10), ("metered", "lteq", 5)])]),
    P("ODRL838", "metered cap exceeded (metered 7 > P5D) -> Conflict", "Conflict",
      "metered=3+4=7 violates meteredTime lteq P5D (7<=5 fails). Runtime conflict.",
      "start=0, now=8, segments [0,3],[4,8]",
      {"start": 0, "now": 8, "s1": 0, "e1": 3, "s2": 4, "e2": 8}, ["elapsed", "metered"],
      [("elapsed", "lteq", 10), ("metered", "lteq", 5)],
      [("policy", [("elapsed", "lteq", 10), ("metered", "lteq", 5)])]),
    P("ODRL839", "elapsed cap exceeded (elapsed 13 > P10D) -> Conflict", "Conflict",
      "elapsed=now-start=13 violates elapsedTime lteq P10D (13<=10 fails). Runtime conflict.",
      "start=0, now=13, segments [0,2],[4,7]",
      {"start": 0, "now": 13, "s1": 0, "e1": 2, "s2": 4, "e2": 7}, ["elapsed", "metered"],
      [("elapsed", "lteq", 10), ("metered", "lteq", 5)],
      [("policy", [("elapsed", "lteq", 10), ("metered", "lteq", 5)])]),
    P("ODRL840", "statically Compatible, runtime Conflict (metered 9 > min cap P8D)", "Conflict",
      "C1 cap P10D and C2 cap P8D are statically Compatible, but metered=4+5=9 violates C2 (9<=8 fails). Thm. static-runtime.",
      "segments [0,4],[5,10] so metered=9; C1 cap P10D, C2 cap P8D",
      {"s1": 0, "e1": 4, "s2": 5, "e2": 10}, ["metered"],
      [("metered", "lteq", 10), ("metered", "lteq", 8)],
      [("policyC1", [("metered", "lteq", 10)]), ("policyC2", [("metered", "lteq", 8)])]),
    P("ODRL841", "delay satisfied (delay 2 >= P1D) -> Compatible", "Compatible",
      "delay=now-trig=2 satisfies delayPeriod gteq P1D (2>=1). Compatible.",
      "trig=0, now=2",
      {"trig": 0, "now": 2}, ["delay"], [("delay", "gteq", 1)],
      [("policy", [("delay", "gteq", 1)])]),
    P("ODRL842", "delay too short (delay 0 < P1D) -> Conflict", "Conflict",
      "delay=now-trig=0 violates delayPeriod gteq P1D (0>=1 fails). Runtime conflict.",
      "trig=0, now=0",
      {"trig": 0, "now": 0}, ["delay"], [("delay", "gteq", 1)],
      [("policy", [("delay", "gteq", 1)])]),
]
