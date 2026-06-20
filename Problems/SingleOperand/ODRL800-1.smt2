; --------------------------------------------------------------------------
; File     : ODRL800-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : dateTime lteq 2026-12-31 & gteq 2027-06-01 -> Conflict
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL800-1.smt2
; Status   : unsat
; Comments : Verdict: Conflict  Category: SingleOperand  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LRA)
(declare-const x Real)
(assert (<= x 20261231.0))
(assert (>= x 20270601.0))
(check-sat)
(exit)
