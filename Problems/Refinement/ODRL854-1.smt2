; --------------------------------------------------------------------------
; File     : ODRL854-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : [i5,i10] refines [i0,i15] -> Refines
; Version  : 1.0
; Authors  : anonymous
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies., 2026.
; Source   : anonymous
; Names    : ODRL854-1.smt2
; Status   : unsat
; Comments : Verdict: Refines  Category: Refinement  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)

(assert (not (and (<= 0 5) (<= 10 15))))
(check-sat)
(exit)
