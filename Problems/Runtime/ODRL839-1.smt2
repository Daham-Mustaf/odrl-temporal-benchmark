; --------------------------------------------------------------------------
; File     : ODRL839-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : elapsed cap exceeded (elapsed 13 > P10D) -> Conflict
; Version  : 1.0
; Authors  : anonymous
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies., 2026.
; Source   : anonymous
; Names    : ODRL839-1.smt2
; Status   : unsat
; Comments : Verdict: Conflict  Category: Runtime  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)
(declare-const start Int)
(declare-const now Int)
(declare-const s1 Int)
(declare-const e1 Int)
(declare-const s2 Int)
(declare-const e2 Int)
(assert (= start 0))
(assert (= now 13))
(assert (= s1 0))
(assert (= e1 2))
(assert (= s2 4))
(assert (= e2 7))
(assert (<= (- now start) 10))
(assert (<= (+ (- e1 s1) (- e2 s2)) 5))
(check-sat)
(exit)
