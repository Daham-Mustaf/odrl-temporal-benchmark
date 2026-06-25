; --------------------------------------------------------------------------
; File     : ODRL801-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : dateTime gteq 2026-06-01 & lteq 2027-06-01 -> Compatible
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL801-1.smt2
; Status   : sat
; Verdict  : Compatible
; Comments : Category: SingleOperand  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LRA)
(declare-const x Real)
(assert (>= x 20260601.0))
(assert (<= x 20270601.0))
(check-sat)
(exit)
