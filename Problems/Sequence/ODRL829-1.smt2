; --------------------------------------------------------------------------
; File     : ODRL829-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : delays >= P5D,P5D within deadline P12D -> Compatible
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
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
