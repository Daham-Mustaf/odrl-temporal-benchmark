; --------------------------------------------------------------------------
; File     : SEQ000-0.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : Sequence / STN (QF_IDL, inlined)
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : SEQ000-0.smt2
; Status   : sat
; Comments : Difference constraints over Int time points; unsat = negative cycle.
; --------------------------------------------------------------------------
; Diff tier: Simple Temporal Network (QF_IDL, inlined per problem).
; Event time points are Int; andSequence edges and duration gaps become
; difference constraints (- t_j t_i) <op> d. Problems declare the time
; points and assert the differences; unsat = Conflict (a negative cycle),
; sat = Compatible.
