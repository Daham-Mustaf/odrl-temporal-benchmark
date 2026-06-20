; --------------------------------------------------------------------------
; File     : ODRL856-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : complete a silent operand compatibly: Unknown -> Compatible
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL856-1.smt2
; Status   : unsat
; Comments : Verdict: Compatible  Category: Completion  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const v1 Int)
(declare-const v2 Int)
(assert (= v1 2))
(assert (= v2 2))
(assert (not (= (ite (<= v1 v2) v1 v2) 2)))
(check-sat)
(exit)
