; --------------------------------------------------------------------------
; File     : ODRL857-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : complete a silent operand incompatibly: Unknown -> Conflict
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL857-1.smt2
; Status   : unsat
; Comments : Verdict: Conflict  Category: Completion  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const v1 Int)
(declare-const v2 Int)
(assert (= v1 2))
(assert (= v2 0))
(assert (not (= (ite (<= v1 v2) v1 v2) 0)))
(check-sat)
(exit)
