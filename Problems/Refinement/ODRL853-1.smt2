; --------------------------------------------------------------------------
; File     : ODRL853-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : [i0,i20] does not refine [i0,i10] -> NotRefines
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL853-1.smt2
; Status   : unsat
; Verdict  : NotRefines
; Comments : Category: Refinement  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)

(assert (and (<= 0 0) (<= 20 10)))
(check-sat)
(exit)
