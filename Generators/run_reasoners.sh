#!/usr/bin/env bash
set -u
ROOT="$HOME/projects/odrl-benchmark"
DIR="${1:-$ROOT/Problems/ODRL/TemporalDecomposition/SingleOperand}"
TO="${2:-10}"
VAMPIRE="$ROOT/build/vampire"
[ -x "$VAMPIRE" ] || VAMPIRE="$(command -v vampire || true)"
EPROVER="$(command -v eprover || true)"
Z3="$(command -v z3 || true)"
CVC5="$(command -v cvc5 || true)"
[ -d "$DIR" ] || { echo "no such dir: $DIR  (run gen_problems.py first)"; exit 1; }
export TPTP="$(cd "$DIR/.." && pwd)"
cd "$DIR"
[ -e Axioms ] || ln -sf ../Axioms Axioms 2>/dev/null
prov=(); [ -x "$VAMPIRE" ] && prov+=(vampire); [ -n "$EPROVER" ] && prov+=(E)
smts=(); [ -n "$Z3" ] && smts+=(z3); [ -n "$CVC5" ] && smts+=(cvc5)
echo "category: $DIR"; echo "TPTP=$TPTP"
echo "timeout : ${TO}s    TPTP: ${prov[*]:-none}    SMT: ${smts[*]:-none}"
[ -x "$VAMPIRE" ] || echo "NOTE: vampire not found -- edit VAMPIRE= in this script"
echo
pass=0; fail=0
chk(){ printf ' %s=%-9s' "$1" "${2:-TO}"; [ "$2" = "$3" ] && pass=$((pass+1)) || fail=$((fail+1)); }
for f in *.p; do [ -e "$f" ] || continue
  exp=$(grep -m1 '% Status' "$f" | awk '{print $4}')
  printf '%-16s exp=%-9s' "$f" "$exp"
  [ -x "$VAMPIRE" ] && chk vampire "$(timeout "$TO" "$VAMPIRE" "$f" 2>/dev/null | grep -m1 -oE 'SZS status [A-Za-z]+' | awk '{print $3}')" "$exp"
  [ -n "$EPROVER" ] && chk E "$(timeout "$TO" "$EPROVER" --auto --cpu-limit="$TO" "$f" 2>/dev/null | grep -m1 -oE 'SZS status [A-Za-z]+' | awk '{print $3}')" "$exp"
  echo
done
[ -n "$(ls *.p 2>/dev/null)" ] && echo
for f in *.smt2; do [ -e "$f" ] || continue
  exp=$(grep -m1 '; Status' "$f" | awk '{print $4}')
  printf '%-16s exp=%-9s' "$f" "$exp"
  [ -n "$Z3" ]   && chk z3   "$(timeout "$TO" "$Z3" "$f"   2>/dev/null | head -1)" "$exp"
  [ -n "$CVC5" ] && chk cvc5 "$(timeout "$TO" "$CVC5" "$f" 2>/dev/null | head -1)" "$exp"
  echo
done
echo; echo "pass=$pass  fail=$fail"
