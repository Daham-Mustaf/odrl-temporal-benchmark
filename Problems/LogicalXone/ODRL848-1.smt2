; --------------------------------------------------------------------------
; File     : ODRL848-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : xone(dateTime gteq 2026-06-01, gteq 2026-08-01) vs eq 2026-04-01 -> Conflict
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL848-1.smt2
; Status   : unsat
; Verdict  : Conflict
; Comments : Category: LogicalXone  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const x Int)
(assert (= x 90))
(assert (or (and (>= x 151) (not (>= x 212))) (and (not (>= x 151)) (>= x 212))))
(check-sat)
(exit)
