; --------------------------------------------------------------------------
; File     : FRAME000-0.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : Cross-operand Phi (QF_LIA, inlined)
; Version  : 1.0
; Authors  : anonymous
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies., 2026.
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
