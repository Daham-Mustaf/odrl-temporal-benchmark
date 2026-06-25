; --------------------------------------------------------------------------
; File     : ODRL825-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : BSB-BnF running example -> Conflict
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL825-1.smt2
; Status   : unsat
; Verdict  : Conflict
; Comments : Category: Capstone  Difficulty: Medium
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
