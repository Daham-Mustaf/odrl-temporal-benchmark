; --------------------------------------------------------------------------
; File     : ODRL829-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : delays >= P5D,P5D within deadline P12D -> Compatible
; Version  : 1.0
; Authors  : anonymous
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies., 2026.
; Source   : anonymous
; Names    : ODRL829-1.smt2
; Status   : sat
; Comments : Verdict: Compatible  Category: Sequence  Difficulty: Medium
; --------------------------------------------------------------------------

(set-logic QF_IDL)
(declare-const p0 Int)
(declare-const p1 Int)
(declare-const p2 Int)
(assert (<= p0 p1))
(assert (>= (- p1 p0) 5))
(assert (<= p1 p2))
(assert (>= (- p2 p1) 5))
(assert (<= (- p2 p0) 12))
(check-sat)
(exit)
