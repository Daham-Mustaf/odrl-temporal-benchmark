; --------------------------------------------------------------------------
; File     : ODRL865-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : single policy with an empty dateTime window -> Unrealizable
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL865-1.smt2
; Status   : unsat
; Verdict  : Unrealizable
; Comments : Category: Realizability  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const x Int)
(assert (and (<= 151 x) (< x 59)))
(check-sat)
(exit)
