; --------------------------------------------------------------------------
; File     : ODRL866-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : single policy with a proper dateTime window -> Realizable
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
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
