; --------------------------------------------------------------------------
; File     : ODRL842-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : delay too short (delay 0 < P1D) -> Conflict
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL842-1.smt2
; Status   : unsat
; Comments : Verdict: Conflict  Category: Runtime  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const trig Int)
(declare-const now Int)
(assert (= trig 0))
(assert (= now 0))
(assert (>= (- now trig) 1))
(check-sat)
(exit)
