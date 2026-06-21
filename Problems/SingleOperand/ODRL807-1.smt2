; --------------------------------------------------------------------------
; File     : ODRL807-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : elapsedTime eq P600D & lteq P1200D -> Compatible
; Version  : 1.0
; Authors  : anonymous
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies., 2026.
; Source   : anonymous
; Names    : ODRL807-1.smt2
; Status   : sat
; Comments : Verdict: Compatible  Category: SingleOperand  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LRA)
(declare-const x Real)
(assert (= x 600.0))
(assert (<= 0.0 x))
(assert (<= x 1200.0))
(check-sat)
(exit)
