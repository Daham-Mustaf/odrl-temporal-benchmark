; --------------------------------------------------------------------------
; File     : ODRL803-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : dateTime gt 2026-06-01 & lt 2027-06-01 -> Compatible (open, density)
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL803-1.smt2
; Status   : sat
; Verdict  : Compatible
; Comments : Category: SingleOperand  Difficulty: Medium
; --------------------------------------------------------------------------

(set-logic QF_LRA)
(declare-const x Real)
(assert (> x 20260601.0))
(assert (< x 20270601.0))
(check-sat)
(exit)
