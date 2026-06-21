; --------------------------------------------------------------------------
; File     : ODRL870-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : sort-stratified reading keeps them incomparable -> no Conflict (Compatible)
; Version  : 1.0
; Authors  : anonymous
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies., 2026.
; Source   : anonymous
; Names    : ODRL870-1.smt2
; Status   : sat
; Comments : Verdict: Compatible  Category: SortAblation  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const xi Int)
(declare-const xd Int)
(assert (>= xi 334))
(assert (<= xd 30))
(check-sat)
(exit)
