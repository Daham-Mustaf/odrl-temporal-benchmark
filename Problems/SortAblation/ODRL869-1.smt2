; --------------------------------------------------------------------------
; File     : ODRL869-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : naive unsorted reading collapses instant and duration -> spurious Conflict
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL869-1.smt2
; Status   : unsat
; Verdict  : Conflict
; Comments : Category: SortAblation  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const x Int)
(assert (>= x 334))
(assert (<= x 30))
(check-sat)
(exit)
