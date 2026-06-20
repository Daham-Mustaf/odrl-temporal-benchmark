; --------------------------------------------------------------------------
; File     : ODRL841-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : delay satisfied (delay 2 >= P1D) -> Compatible
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL841-1.smt2
; Status   : sat
; Comments : Verdict: Compatible  Category: Runtime  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const trig Int)
(declare-const now Int)
(assert (= trig 0))
(assert (= now 2))
(assert (>= (- now trig) 1))
(check-sat)
(exit)
