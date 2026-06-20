; --------------------------------------------------------------------------
; File     : ODRL820-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : timeInterval eq P30D & eq P45D, BSB-BnF offset 516 -> Conflict
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL820-1.smt2
; Status   : unsat
; Comments : Verdict: Conflict  Category: Periodic  Difficulty: Hard
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const t Int)
(declare-const k Int)
(declare-const m Int)
(assert (>= k 0))
(assert (>= m 0))
(assert (= t (+ 0 (* 30 k))))
(assert (= t (+ 516 (* 45 m))))
(check-sat)
(exit)
