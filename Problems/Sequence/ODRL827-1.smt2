; --------------------------------------------------------------------------
; File     : ODRL827-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : delay >= P3D within elapsed deadline P5D -> Compatible
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL827-1.smt2
; Status   : sat
; Comments : Verdict: Compatible  Category: Sequence  Difficulty: Medium
; --------------------------------------------------------------------------

(set-logic QF_IDL)
(declare-const p0 Int)
(declare-const p1 Int)
(assert (<= p0 p1))
(assert (>= (- p1 p0) 3))
(assert (<= (- p1 p0) 5))
(check-sat)
(exit)
