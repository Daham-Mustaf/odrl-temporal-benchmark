; --------------------------------------------------------------------------
; File     : ODRL857-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : complete a silent operand incompatibly: Unknown -> Conflict
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL857-1.smt2
; Status   : unsat
; Verdict  : Conflict
; Comments : Category: Completion  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const v1 Int)
(declare-const v2 Int)
(assert (= v1 2))
(assert (= v2 0))
(assert (not (= (ite (<= v1 v2) v1 v2) 0)))
(check-sat)
(exit)
