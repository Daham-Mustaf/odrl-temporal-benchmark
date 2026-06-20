; --------------------------------------------------------------------------
; File     : SEQ000-0.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : Sequence / STN (QF_IDL, inlined)
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
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
