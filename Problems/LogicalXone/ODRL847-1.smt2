; --------------------------------------------------------------------------
; File     : ODRL847-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : xone(dateTime gteq 2026-06-01, gteq 2026-08-01) vs eq 2026-07-01 -> Compatible
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ODRL847-1.smt2
; Status   : sat
; Comments : Verdict: Compatible  Category: LogicalXone  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const x Int)
(assert (= x 181))
(assert (or (and (>= x 151) (not (>= x 212))) (and (not (>= x 151)) (>= x 212))))
(check-sat)
(exit)
