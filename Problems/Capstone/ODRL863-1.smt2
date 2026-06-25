; --------------------------------------------------------------------------
; File     : ODRL863-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : BSB-BnF running example, four-operand verdict vector -> Conflict
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL863-1.smt2
; Status   : unsat
; Verdict  : Conflict
; Comments : Category: Capstone  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)

(assert (not (= (ite (<= (ite (<= (ite (<= 0 2) 0 2) 1) (ite (<= 0 2) 0 2) 1) 0) (ite (<= (ite (<= 0 2) 0 2) 1) (ite (<= 0 2) 0 2) 1) 0) 0)))
(check-sat)
(exit)
