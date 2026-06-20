; --------------------------------------------------------------------------
; File     : ODRL839-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : elapsed cap exceeded (elapsed 13 > P10D) -> Conflict
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL839-1.smt2
; Status   : unsat
; Comments : Verdict: Conflict  Category: Runtime  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const start Int)
(declare-const now Int)
(declare-const s1 Int)
(declare-const e1 Int)
(declare-const s2 Int)
(declare-const e2 Int)
(assert (= start 0))
(assert (= now 13))
(assert (= s1 0))
(assert (= e1 2))
(assert (= s2 4))
(assert (= e2 7))
(assert (<= (- now start) 10))
(assert (<= (+ (- e1 s1) (- e2 s2)) 5))
(check-sat)
(exit)
