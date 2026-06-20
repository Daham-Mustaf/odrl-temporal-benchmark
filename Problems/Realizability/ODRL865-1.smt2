; --------------------------------------------------------------------------
; File     : ODRL865-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : single policy with an empty dateTime window -> Unrealizable
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
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
