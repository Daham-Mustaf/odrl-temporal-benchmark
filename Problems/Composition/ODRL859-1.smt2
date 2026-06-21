; --------------------------------------------------------------------------
; File     : ODRL859-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Axioms   : and over three compatible operands -> Compatible
; Version  : 1.0
; Authors  : anonymous
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies., 2026.
; Source   : anonymous
; Names    : ODRL859-1.smt2
; Status   : unsat
; Comments : Verdict: Compatible  Category: Composition  Difficulty: Easy
; --------------------------------------------------------------------------

(set-logic QF_LIA)

(assert (not (= (ite (<= (ite (<= 2 2) 2 2) 2) (ite (<= 2 2) 2 2) 2) 2)))
(check-sat)
(exit)
