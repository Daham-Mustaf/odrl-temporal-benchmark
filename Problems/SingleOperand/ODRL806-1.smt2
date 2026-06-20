; --------------------------------------------------------------------------
; File     : ODRL806-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : elapsedTime eq P600D & lteq P300D -> Conflict
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL806-1.smt2
; Status   : unsat
; Comments : Verdict: Conflict  Category: SingleOperand  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LRA)
(declare-const x Real)
(assert (= x 600.0))
(assert (<= 0.0 x))
(assert (<= x 300.0))
(check-sat)
(exit)
