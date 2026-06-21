; --------------------------------------------------------------------------
; File     : ODRL863-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : BSB-BnF running example, four-operand verdict vector -> Conflict
; Version  : 1.0
; Authors  : anonymous
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies., 2026.
; Source   : anonymous
; Names    : ODRL863-1.smt2
; Status   : unsat
; Comments : Verdict: Conflict  Category: Capstone  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)

(assert (not (= (ite (<= (ite (<= (ite (<= 0 2) 0 2) 1) (ite (<= 0 2) 0 2) 1) 0) (ite (<= (ite (<= 0 2) 0 2) 1) (ite (<= 0 2) 0 2) 1) 0) 0)))
(check-sat)
(exit)
