; --------------------------------------------------------------------------
; File     : ODRL826-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : BSB-BnF compatible variant -> Compatible
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL826-1.smt2
; Status   : sat
; Comments : Verdict: Compatible  Category: Capstone  Difficulty: Medium
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const dt Int)
(declare-const el Int)
(declare-const dl Int)
(declare-const k Int)
(declare-const m Int)
(assert (>= el 0))
(assert (>= dl 0))
(assert (< dt 364))
(assert (<= el 30))
(assert (>= dl 1))
(assert (= dt (* 30 k)))
(assert (>= k 0))
(assert (= dt 150))
(assert (<= el 20))
(assert (= dt (* 30 m)))
(assert (>= m 0))
(check-sat)
(exit)
