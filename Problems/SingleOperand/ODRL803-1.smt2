; --------------------------------------------------------------------------
; File     : ODRL803-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : dateTime gt 2026-06-01 & lt 2027-06-01 -> Compatible (open, density)
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL803-1.smt2
; Status   : sat
; Comments : Verdict: Compatible  Category: SingleOperand  Difficulty: Medium
; --------------------------------------------------------------------------

(set-logic QF_LRA)
(declare-const x Real)
(assert (> x 20260601.0))
(assert (< x 20270601.0))
(check-sat)
(exit)
