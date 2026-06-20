; --------------------------------------------------------------------------
; File     : ODRL833-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : [i0,i10] vs [i10,i20], both closed at i10 -> Compatible
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL833-1.smt2
; Status   : sat
; Comments : Verdict: Compatible  Category: ConflictCriterion  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const x Int)
(assert (>= x 0))
(assert (<= x 10))
(assert (>= x 10))
(assert (<= x 20))
(check-sat)
(exit)
