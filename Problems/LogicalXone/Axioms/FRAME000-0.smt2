; --------------------------------------------------------------------------
; File     : FRAME000-0.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : Cross-operand Phi (QF_LIA, inlined)
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : FRAME000-0.smt2
; Status   : sat
; Comments : Durations >= 0 and metered <= elapsed; inlined per problem.
; --------------------------------------------------------------------------
; Cross-operand background theory Phi (QF_LIA, inlined per problem):
;   elapsedTime, meteredTime, delayPeriod >= 0   (Int, day counts)
;   meteredTime <= elapsedTime
; Problems declare the relevant quantities as Int and assert Phi + the
; per-operand constraints; unsat = Conflict, sat = Compatible.
