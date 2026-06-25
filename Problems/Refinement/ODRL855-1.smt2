; --------------------------------------------------------------------------
; File     : ODRL855-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : [i0,i10] does not refine [i5,i15] -> NotRefines
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL855-1.smt2
; Status   : unsat
; Verdict  : NotRefines
; Comments : Category: Refinement  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)

(assert (and (<= 5 0) (<= 10 15)))
(check-sat)
(exit)
