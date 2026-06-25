; --------------------------------------------------------------------------
; File     : ODRL868-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : andSequence fits within its cap -> Realizable
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL868-1.smt2
; Status   : sat
; Verdict  : Realizable
; Comments : Category: Realizability  Difficulty: Medium
; --------------------------------------------------------------------------

(set-logic QF_LIA)

(declare-const p1 Int)
(declare-const p2 Int)
(assert (>= p1 5))
(assert (>= (- p2 p1) 5))
(assert (<= p2 12))
(check-sat)
(exit)
