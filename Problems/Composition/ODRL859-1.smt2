; --------------------------------------------------------------------------
; File     : ODRL859-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : and over three compatible operands -> Compatible
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL859-1.smt2
; Status   : unsat
; Verdict  : Compatible
; Comments : Category: Composition  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)

(assert (not (= (ite (<= (ite (<= 2 2) 2 2) 2) (ite (<= 2 2) 2 2) 2) 2)))
(check-sat)
(exit)
