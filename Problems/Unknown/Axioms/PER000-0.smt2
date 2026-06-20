; --------------------------------------------------------------------------
; File     : PER000-0.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : Periodic recurrence (QF_LIA)
; Version  : 1.0
; Authors  : anonymous
; Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
; Source   : anonymous
; Names    : PER000-0.smt2
; Status   : sat
; Comments : Linear integer recurrence; sat = compatible, unsat = conflict.
; --------------------------------------------------------------------------
; Mod tier: periodic recurrence over the integer timeline (QF_LIA).
; A period-P schedule anchored at A:  t = A + P*k, with k >= 0  (k : Int).
; Two schedules coincide iff  ?t,k,m >= 0 . A1 + P1*k = A2 + P2*m,
; equivalently gcd(P1,P2) | (A2 - A1). Problems inline this directly;
; sat = compatible, unsat = conflict.
