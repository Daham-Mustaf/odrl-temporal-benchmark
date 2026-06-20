; --------------------------------------------------------------------------
; File     : ODRL861-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : one silent operand makes the and-fold Unknown
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL861-1.smt2
; Status   : unsat
; Comments : Verdict: Unknown  Category: Composition  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)

(assert (not (= (ite (<= (ite (<= 2 2) 2 2) 1) (ite (<= 2 2) 2 2) 1) 1)))
(check-sat)
(exit)
