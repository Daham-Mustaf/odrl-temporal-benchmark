; --------------------------------------------------------------------------
; File     : ODRL864-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : BSB-BnF structure with conflicts resolved -> Unknown
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL864-1.smt2
; Status   : unsat
; Verdict  : Unknown
; Comments : Category: Capstone  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)

(assert (not (= (ite (<= (ite (<= (ite (<= 2 2) 2 2) 1) (ite (<= 2 2) 2 2) 1) 2) (ite (<= (ite (<= 2 2) 2 2) 1) (ite (<= 2 2) 2 2) 1) 2) 1)))
(check-sat)
(exit)
