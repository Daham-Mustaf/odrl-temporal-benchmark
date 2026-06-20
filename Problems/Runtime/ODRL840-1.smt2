; --------------------------------------------------------------------------
; File     : ODRL840-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : statically Compatible, runtime Conflict (metered 9 > min cap P8D)
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL840-1.smt2
; Status   : unsat
; Comments : Verdict: Conflict  Category: Runtime  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const s1 Int)
(declare-const e1 Int)
(declare-const s2 Int)
(declare-const e2 Int)
(assert (= s1 0))
(assert (= e1 4))
(assert (= s2 5))
(assert (= e2 10))
(assert (<= (+ (- e1 s1) (- e2 s2)) 10))
(assert (<= (+ (- e1 s1) (- e2 s2)) 8))
(check-sat)
(exit)
