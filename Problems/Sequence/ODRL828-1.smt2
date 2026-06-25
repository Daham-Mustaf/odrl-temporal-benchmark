; --------------------------------------------------------------------------
; File     : ODRL828-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : delay >= P5D within elapsed deadline P3D -> Conflict
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL828-1.smt2
; Status   : unsat
; Verdict  : Conflict
; Comments : Category: Sequence  Difficulty: Medium
; --------------------------------------------------------------------------

(set-logic QF_IDL)
(declare-const p0 Int)
(declare-const p1 Int)
(assert (<= p0 p1))
(assert (>= (- p1 p0) 5))
(assert (<= (- p1 p0) 3))
(check-sat)
(exit)
