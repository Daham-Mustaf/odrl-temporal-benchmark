; --------------------------------------------------------------------------
; File     : ODRL859-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : and over three compatible operands -> Compatible
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL859-1.smt2
; Status   : unsat
; Comments : Verdict: Compatible  Category: Composition  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)

(assert (not (= (ite (<= (ite (<= 2 2) 2 2) 2) (ite (<= 2 2) 2 2) 2) 2)))
(check-sat)
(exit)
