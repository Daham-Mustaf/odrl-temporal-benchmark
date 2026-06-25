; --------------------------------------------------------------------------
; File     : PER000-0.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : Periodic recurrence (QF_LIA)
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : PER000-0.smt2
; Status   : sat
; Comments : Linear integer recurrence; sat = compatible, unsat = conflict.
; --------------------------------------------------------------------------
; Mod tier: periodic recurrence over the integer timeline (QF_LIA).
; A period-P schedule anchored at A:  t = A + P*k, with k >= 0  (k : Int).
; Two schedules coincide iff  ?t,k,m >= 0 . A1 + P1*k = A2 + P2*m,
; equivalently gcd(P1,P2) | (A2 - A1). Problems inline this directly;
; sat = compatible, unsat = conflict.
