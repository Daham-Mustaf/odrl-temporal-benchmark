; --------------------------------------------------------------------------
; File     : ODRL841-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : delay satisfied (delay 2 >= P1D) -> Compatible
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL841-1.smt2
; Status   : sat
; Verdict  : Compatible
; Comments : Category: Runtime  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const trig Int)
(declare-const now Int)
(assert (= trig 0))
(assert (= now 2))
(assert (>= (- now trig) 1))
(check-sat)
(exit)
