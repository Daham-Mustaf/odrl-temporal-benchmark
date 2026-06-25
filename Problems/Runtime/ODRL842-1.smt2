; --------------------------------------------------------------------------
; File     : ODRL842-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : delay too short (delay 0 < P1D) -> Conflict
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL842-1.smt2
; Status   : unsat
; Verdict  : Conflict
; Comments : Category: Runtime  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const trig Int)
(declare-const now Int)
(assert (= trig 0))
(assert (= now 0))
(assert (>= (- now trig) 1))
(check-sat)
(exit)
