; --------------------------------------------------------------------------
; File     : ODRL864-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : BSB-BnF structure with conflicts resolved -> Unknown
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL864-1.smt2
; Status   : unsat
; Comments : Verdict: Unknown  Category: Capstone  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)

(assert (not (= (ite (<= (ite (<= (ite (<= 2 2) 2 2) 1) (ite (<= 2 2) 2 2) 1) 2) (ite (<= (ite (<= 2 2) 2 2) 1) (ite (<= 2 2) 2 2) 1) 2) 1)))
(check-sat)
(exit)
