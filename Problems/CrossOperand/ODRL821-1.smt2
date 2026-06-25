; --------------------------------------------------------------------------
; File     : ODRL821-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : meteredTime eq P20D & elapsedTime lteq P10D -> Conflict (via Phi)
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL821-1.smt2
; Status   : unsat
; Verdict  : Conflict
; Comments : Category: CrossOperand  Difficulty: Medium
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const me Int)
(declare-const el Int)
(assert (>= me 0))
(assert (>= el 0))
(assert (<= me el))
(assert (= me 20))
(assert (<= el 10))
(check-sat)
(exit)
