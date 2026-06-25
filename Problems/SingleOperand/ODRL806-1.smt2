; --------------------------------------------------------------------------
; File     : ODRL806-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : elapsedTime eq P600D & lteq P300D -> Conflict
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL806-1.smt2
; Status   : unsat
; Verdict  : Conflict
; Comments : Category: SingleOperand  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LRA)
(declare-const x Real)
(assert (= x 600.0))
(assert (<= 0.0 x))
(assert (<= x 300.0))
(check-sat)
(exit)
