; --------------------------------------------------------------------------
; File     : ODRL832-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : [i0,i10] vs [i5,i15] -> Compatible (overlap)
; Version  : 1.0
; Authors  : anonymous
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies., 2026.
; Source   : anonymous
; Names    : ODRL832-1.smt2
; Status   : sat
; Comments : Verdict: Compatible  Category: ConflictCriterion  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const x Int)
(assert (>= x 0))
(assert (<= x 10))
(assert (>= x 5))
(assert (<= x 15))
(check-sat)
(exit)
