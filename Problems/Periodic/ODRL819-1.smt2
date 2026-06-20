; --------------------------------------------------------------------------
; File     : ODRL819-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : timeInterval eq P30D & eq P30D, offset 60 -> Compatible
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL819-1.smt2
; Status   : sat
; Comments : Verdict: Compatible  Category: Periodic  Difficulty: Medium
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const t Int)
(declare-const k Int)
(declare-const m Int)
(assert (>= k 0))
(assert (>= m 0))
(assert (= t (+ 0 (* 30 k))))
(assert (= t (+ 60 (* 30 m))))
(check-sat)
(exit)
