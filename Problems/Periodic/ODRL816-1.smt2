; --------------------------------------------------------------------------
; File     : ODRL816-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : timeInterval eq P30D & eq P45D, aligned anchors -> Compatible
; Version  : 1.0
; Authors  : anonymous
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies., 2026.
; Source   : anonymous
; Names    : ODRL816-1.smt2
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
(assert (= t (+ 0 (* 45 m))))
(check-sat)
(exit)
