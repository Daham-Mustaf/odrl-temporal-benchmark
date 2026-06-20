; --------------------------------------------------------------------------
; File     : ODRL869-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : naive unsorted reading collapses instant and duration -> spurious Conflict
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL869-1.smt2
; Status   : unsat
; Comments : Verdict: Conflict  Category: SortAblation  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const x Int)
(assert (>= x 334))
(assert (<= x 30))
(check-sat)
(exit)
