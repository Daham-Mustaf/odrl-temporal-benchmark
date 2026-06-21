; --------------------------------------------------------------------------
; File     : ODRL868-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : andSequence fits within its cap -> Realizable
; Version  : 1.0
; Authors  : anonymous
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies., 2026.
; Source   : anonymous
; Names    : ODRL868-1.smt2
; Status   : sat
; Comments : Verdict: Realizable  Category: Realizability  Difficulty: Medium
; --------------------------------------------------------------------------

(set-logic QF_LIA)

(declare-const p1 Int)
(declare-const p2 Int)
(assert (>= p1 5))
(assert (>= (- p2 p1) 5))
(assert (<= p2 12))
(check-sat)
(exit)
