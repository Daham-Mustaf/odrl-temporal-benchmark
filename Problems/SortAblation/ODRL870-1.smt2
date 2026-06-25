; --------------------------------------------------------------------------
; File     : ODRL870-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : sort-stratified reading keeps them incomparable -> no Conflict (Compatible)
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL870-1.smt2
; Status   : sat
; Verdict  : Compatible
; Comments : Category: SortAblation  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const xi Int)
(declare-const xd Int)
(assert (>= xi 334))
(assert (<= xd 30))
(check-sat)
(exit)
