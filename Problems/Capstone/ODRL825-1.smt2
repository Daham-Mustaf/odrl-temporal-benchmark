; --------------------------------------------------------------------------
; File     : ODRL825-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : BSB-BnF running example -> Conflict
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL825-1.smt2
; Status   : unsat
; Comments : Verdict: Conflict  Category: Capstone  Difficulty: Medium
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
(assert (= dt 516))
(assert (<= el 10))
(assert (= dt (+ 516 (* 45 m))))
(assert (>= m 0))
(check-sat)
(exit)
