; --------------------------------------------------------------------------
; File     : ODRL828-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : delay >= P5D within elapsed deadline P3D -> Conflict
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL828-1.smt2
; Status   : unsat
; Comments : Verdict: Conflict  Category: Sequence  Difficulty: Medium
; --------------------------------------------------------------------------

(set-logic QF_IDL)
(declare-const p0 Int)
(declare-const p1 Int)
(assert (<= p0 p1))
(assert (>= (- p1 p0) 5))
(assert (<= (- p1 p0) 3))
(check-sat)
(exit)
