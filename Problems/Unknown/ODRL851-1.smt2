; --------------------------------------------------------------------------
; File     : ODRL851-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : two silent operands -> Unknown
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL851-1.smt2
; Status   : unsat
; Comments : Verdict: Unknown  Category: Unknown  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const v1 Int)
(declare-const v2 Int)
(assert (= v1 1))
(assert (= v2 1))
(assert (not (= (ite (<= v1 v2) v1 v2) 1)))
(check-sat)
(exit)
