; --------------------------------------------------------------------------
; File     : ODRL862-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : conflict dominates an unknown in the and-fold -> Conflict
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL862-1.smt2
; Status   : unsat
; Comments : Verdict: Conflict  Category: Composition  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)

(assert (not (= (ite (<= (ite (<= 0 2) 0 2) 1) (ite (<= 0 2) 0 2) 1) 0)))
(check-sat)
(exit)
