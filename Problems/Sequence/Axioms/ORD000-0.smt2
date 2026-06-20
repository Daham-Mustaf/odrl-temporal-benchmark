; --------------------------------------------------------------------------
; File     : ORD000-0.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : Strict total order (Real model)
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : ORD000-0.smt2
; Status   : sat
; Comments : Order from the Real theory; less/leq macros mirror the TPTP names.
; --------------------------------------------------------------------------
; Instants and durations are modelled as Real (dense, ordered).
; Strict less and its reflexive closure leq mirror the TPTP predicate names.
(define-fun less ((x Real) (y Real)) Bool (< x y))
(define-fun leq  ((x Real) (y Real)) Bool (<= x y))
