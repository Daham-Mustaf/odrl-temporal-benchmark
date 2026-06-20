; --------------------------------------------------------------------------
; File     : ODRL853-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : [i0,i20] does not refine [i0,i10] -> NotRefines
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL853-1.smt2
; Status   : unsat
; Comments : Verdict: NotRefines  Category: Refinement  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)

(assert (and (<= 0 0) (<= 20 10)))
(check-sat)
(exit)
