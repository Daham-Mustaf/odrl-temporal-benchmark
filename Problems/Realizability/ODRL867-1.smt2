; --------------------------------------------------------------------------
; File     : ODRL867-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : andSequence demands more delay than its own cap -> Unrealizable
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL867-1.smt2
; Status   : unsat
; Comments : Verdict: Unrealizable  Category: Realizability  Difficulty: Medium
; --------------------------------------------------------------------------

(set-logic QF_LIA)

(declare-const p1 Int)
(declare-const p2 Int)
(assert (>= p1 5))
(assert (>= (- p2 p1) 5))
(assert (<= p2 8))
(check-sat)
(exit)
