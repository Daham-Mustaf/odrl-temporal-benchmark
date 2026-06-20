; --------------------------------------------------------------------------
; File     : ODRL810-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : delayPeriod eq P5D & gteq P1D -> Compatible
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL810-1.smt2
; Status   : sat
; Comments : Verdict: Compatible  Category: SingleOperand  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LRA)
(declare-const x Real)
(assert (= x 5.0))
(assert (>= x 1.0))
(check-sat)
(exit)
