; --------------------------------------------------------------------------
; File     : ODRL824-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : meteredTime lteq P10D & elapsedTime eq P20D -> Compatible
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL824-1.smt2
; Status   : sat
; Comments : Verdict: Compatible  Category: CrossOperand  Difficulty: Medium
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const me Int)
(declare-const el Int)
(assert (>= me 0))
(assert (>= el 0))
(assert (<= me el))
(assert (<= me 10))
(assert (= el 20))
(check-sat)
(exit)
