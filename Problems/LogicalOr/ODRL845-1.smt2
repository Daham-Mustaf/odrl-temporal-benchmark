; --------------------------------------------------------------------------
; File     : ODRL845-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : or(dateTime gteq 2026-06-01, gteq 2026-08-01) vs eq 2026-07-01 -> Compatible
; Version  : 1.0
; Authors  : anonymous
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies., 2026.
; Source   : anonymous
; Names    : ODRL845-1.smt2
; Status   : sat
; Comments : Verdict: Compatible  Category: LogicalOr  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const x Int)
(assert (= x 181))
(assert (or (>= x 151) (>= x 212)))
(check-sat)
(exit)
