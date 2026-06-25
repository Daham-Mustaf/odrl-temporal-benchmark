; --------------------------------------------------------------------------
; File     : ODRL822-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : meteredTime eq P5D & elapsedTime lteq P10D -> Compatible
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL822-1.smt2
; Status   : sat
; Verdict  : Compatible
; Comments : Category: CrossOperand  Difficulty: Medium
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
