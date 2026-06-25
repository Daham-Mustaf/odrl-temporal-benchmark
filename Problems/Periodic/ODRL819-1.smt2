; --------------------------------------------------------------------------
; File     : ODRL819-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : timeInterval eq P30D & eq P30D, offset 60 -> Compatible
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL819-1.smt2
; Status   : sat
; Verdict  : Compatible
; Comments : Category: Periodic  Difficulty: Medium
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
