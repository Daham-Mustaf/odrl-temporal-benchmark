; --------------------------------------------------------------------------
; File     : DUR000-0.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : Duration zero and non-negativity (Real model)
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : DUR000-0.smt2
; Status   : sat
; Comments : Durations are non-negative Reals; period indices use Int (Mod tier).
; --------------------------------------------------------------------------
; Zero duration and the non-negativity convention.
; Each duration variable d asserts (leq d0 d) in its problem.
(define-fun d0 () Real 0.0)
