; --------------------------------------------------------------------------
; File     : ODRL832-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : [i0,i10] vs [i5,i15] -> Compatible (overlap)
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL832-1.smt2
; Status   : sat
; Verdict  : Compatible
; Comments : Category: ConflictCriterion  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const x Int)
(assert (>= x 0))
(assert (<= x 10))
(assert (>= x 5))
(assert (<= x 15))
(check-sat)
(exit)
