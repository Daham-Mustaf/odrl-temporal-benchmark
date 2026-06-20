; --------------------------------------------------------------------------
; File     : ODRL822-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : meteredTime eq P5D & elapsedTime lteq P10D -> Compatible
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL822-1.smt2
; Status   : sat
; Comments : Verdict: Compatible  Category: CrossOperand  Difficulty: Medium
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const me Int)
(declare-const el Int)
(assert (>= me 0))
(assert (>= el 0))
(assert (<= me el))
(assert (= me 5))
(assert (<= el 10))
(check-sat)
(exit)
