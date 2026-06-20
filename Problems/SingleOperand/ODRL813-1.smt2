; --------------------------------------------------------------------------
; File     : ODRL813-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : meteredTime eq P30D & lteq P10D -> Conflict
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL813-1.smt2
; Status   : unsat
; Comments : Verdict: Conflict  Category: SingleOperand  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LRA)
(declare-const x Real)
(assert (= x 30.0))
(assert (>= x 0.0))
(assert (<= x 10.0))
(check-sat)
(exit)
