; --------------------------------------------------------------------------
; File     : ODRL867-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : andSequence demands more delay than its own cap -> Unrealizable
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL867-1.smt2
; Status   : unsat
; Verdict  : Unrealizable
; Comments : Category: Realizability  Difficulty: Medium
; --------------------------------------------------------------------------

(set-logic QF_LIA)

(declare-const p1 Int)
(declare-const p2 Int)
(assert (>= p1 5))
(assert (>= (- p2 p1) 5))
(assert (<= p2 8))
(check-sat)
(exit)
