; --------------------------------------------------------------------------
; File     : ODRL838-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : metered cap exceeded (metered 7 > P5D) -> Conflict
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL838-1.smt2
; Status   : unsat
; Verdict  : Conflict
; Comments : Category: Runtime  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const start Int)
(declare-const now Int)
(declare-const s1 Int)
(declare-const e1 Int)
(declare-const s2 Int)
(declare-const e2 Int)
(assert (= start 0))
(assert (= now 8))
(assert (= s1 0))
(assert (= e1 3))
(assert (= s2 4))
(assert (= e2 8))
(assert (<= (- now start) 10))
(assert (<= (+ (- e1 s1) (- e2 s2)) 5))
(check-sat)
(exit)
