; --------------------------------------------------------------------------
; File     : ODRL852-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : [i0,i5] refines [i0,i10] -> Refines
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL852-1.smt2
; Status   : unsat
; Verdict  : Refines
; Comments : Category: Refinement  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)

(assert (not (and (<= 0 0) (<= 5 10))))
(check-sat)
(exit)
