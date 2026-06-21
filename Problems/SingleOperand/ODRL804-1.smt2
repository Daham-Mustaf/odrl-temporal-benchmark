; --------------------------------------------------------------------------
; File     : ODRL804-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : elapsedTime lteq P600D & eq P1200D -> Conflict
; Version  : 1.0
; Authors  : anonymous
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies., 2026.
; Source   : anonymous
; Names    : ODRL804-1.smt2
; Status   : unsat
; Comments : Verdict: Conflict  Category: SingleOperand  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LRA)
(declare-const x Real)
(assert (<= 0.0 x))
(assert (<= x 600.0))
(assert (= x 1200.0))
(check-sat)
(exit)
