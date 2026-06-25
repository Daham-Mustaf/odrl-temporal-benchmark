; --------------------------------------------------------------------------
; File     : FRAME000-0.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : Cross-operand Phi (QF_LIA, inlined)
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : FRAME000-0.smt2
; Status   : sat
; Comments : Durations >= 0 and metered <= elapsed; inlined per problem.
; --------------------------------------------------------------------------
; Cross-operand background theory Phi (QF_LIA, inlined per problem):
;   elapsedTime, meteredTime, delayPeriod >= 0   (Int, day counts)
;   meteredTime <= elapsedTime
; Problems declare the relevant quantities as Int and assert Phi + the
; per-operand constraints; unsat = Conflict, sat = Compatible.
