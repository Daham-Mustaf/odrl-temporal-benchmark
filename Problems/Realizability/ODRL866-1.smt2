; --------------------------------------------------------------------------
; File     : ODRL866-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : single policy with a proper dateTime window -> Realizable
; Version  : 1.0
; Authors  : anonymous
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies., 2026.
; Source   : anonymous
; Names    : ODRL866-1.smt2
; Status   : sat
; Comments : Verdict: Realizable  Category: Realizability  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const x Int)
(assert (and (<= 59 x) (< x 151)))
(check-sat)
(exit)
