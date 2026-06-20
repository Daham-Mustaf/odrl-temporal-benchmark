; --------------------------------------------------------------------------
; File     : DUR000-0.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : Duration zero and non-negativity (Real model)
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : DUR000-0.smt2
; Status   : sat
; Comments : Durations are non-negative Reals; period indices use Int (Mod tier).
; --------------------------------------------------------------------------
; Zero duration and the non-negativity convention.
; Each duration variable d asserts (leq d0 d) in its problem.
(define-fun d0 () Real 0.0)
