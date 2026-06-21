; --------------------------------------------------------------------------
; File     : ODRL856-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : complete a silent operand compatibly: Unknown -> Compatible
; Version  : 1.0
; Authors  : anonymous
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies., 2026.
; Source   : anonymous
; Names    : ODRL856-1.smt2
; Status   : unsat
; Comments : Verdict: Compatible  Category: Completion  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const v1 Int)
(declare-const v2 Int)
(assert (= v1 2))
(assert (= v2 2))
(assert (not (= (ite (<= v1 v2) v1 v2) 2)))
(check-sat)
(exit)
