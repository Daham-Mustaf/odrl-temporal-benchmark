; --------------------------------------------------------------------------
; File     : ODRL840-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : statically Compatible, runtime Conflict (metered 9 > min cap P8D)
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL840-1.smt2
; Status   : unsat
; Verdict  : Conflict
; Comments : Category: Runtime  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const s1 Int)
(declare-const e1 Int)
(declare-const s2 Int)
(declare-const e2 Int)
(assert (= s1 0))
(assert (= e1 4))
(assert (= s2 5))
(assert (= e2 10))
(assert (<= (+ (- e1 s1) (- e2 s2)) 10))
(assert (<= (+ (- e1 s1) (- e2 s2)) 8))
(check-sat)
(exit)
