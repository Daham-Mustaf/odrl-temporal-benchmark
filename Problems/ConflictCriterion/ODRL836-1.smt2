; --------------------------------------------------------------------------
; File     : ODRL836-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : [i0,i10) vs (i10,i20], both open at i10 -> Conflict
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL836-1.smt2
; Status   : unsat
; Verdict  : Conflict
; Comments : Category: ConflictCriterion  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const x Int)
(assert (>= x 0))
(assert (< x 10))
(assert (> x 10))
(assert (<= x 20))
(check-sat)
(exit)
