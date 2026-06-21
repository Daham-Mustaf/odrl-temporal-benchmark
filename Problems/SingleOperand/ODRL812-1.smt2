; --------------------------------------------------------------------------
; File     : ODRL812-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : meteredTime lteq P10D & lteq P30D -> Compatible
; Version  : 1.0
; Authors  : anonymous
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies., 2026.
; Source   : anonymous
; Names    : ODRL812-1.smt2
; Status   : sat
; Comments : Verdict: Compatible  Category: SingleOperand  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LRA)
(declare-const x Real)
(assert (>= x 0.0))
(assert (<= x 10.0))
(assert (<= x 30.0))
(check-sat)
(exit)
