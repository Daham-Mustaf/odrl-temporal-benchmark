; --------------------------------------------------------------------------
; File     : ORD000-0.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : Strict total order (Real model)
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ORD000-0.smt2
; Status   : sat
; Comments : Order from the Real theory; less/leq macros mirror the TPTP names.
; --------------------------------------------------------------------------
; Instants and durations are modelled as Real (dense, ordered).
; Strict less and its reflexive closure leq mirror the TPTP predicate names.
(define-fun less ((x Real) (y Real)) Bool (< x y))
(define-fun leq  ((x Real) (y Real)) Bool (<= x y))
