; --------------------------------------------------------------------------
; File     : ODRL852-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : [i0,i5] refines [i0,i10] -> Refines
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL852-1.smt2
; Status   : unsat
; Comments : Verdict: Refines  Category: Refinement  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)

(assert (not (and (<= 0 0) (<= 5 10))))
(check-sat)
(exit)
