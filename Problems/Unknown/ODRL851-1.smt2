; --------------------------------------------------------------------------
; File     : ODRL851-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : two silent operands -> Unknown
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL851-1.smt2
; Status   : unsat
; Verdict  : Unknown
; Comments : Category: Unknown  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const v1 Int)
(declare-const v2 Int)
(assert (= v1 1))
(assert (= v2 1))
(assert (not (= (ite (<= v1 v2) v1 v2) 1)))
(check-sat)
(exit)
