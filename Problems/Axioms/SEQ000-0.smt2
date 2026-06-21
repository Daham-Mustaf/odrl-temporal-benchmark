; --------------------------------------------------------------------------
; File     : SEQ000-0.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : Sequence / STN (QF_IDL, inlined)
; Version  : 1.0
; Authors  : anonymous
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies., 2026.
; Source   : anonymous
; Names    : SEQ000-0.smt2
; Status   : sat
; Comments : Difference constraints over Int time points; unsat = negative cycle.
; --------------------------------------------------------------------------
; Diff tier: Simple Temporal Network (QF_IDL, inlined per problem).
; Event time points are Int; andSequence edges and duration gaps become
; difference constraints (- t_j t_i) <op> d. Problems declare the time
; points and assert the differences; unsat = Conflict (a negative cycle),
; sat = Compatible.
