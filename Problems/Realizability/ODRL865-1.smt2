; --------------------------------------------------------------------------
; File     : ODRL865-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : single policy with an empty dateTime window -> Unrealizable
; Version  : 1.0
; Authors  : anonymous
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies., 2026.
; Source   : anonymous
; Names    : ODRL865-1.smt2
; Status   : unsat
; Comments : Verdict: Unrealizable  Category: Realizability  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const x Int)
(assert (and (<= 151 x) (< x 59)))
(check-sat)
(exit)
