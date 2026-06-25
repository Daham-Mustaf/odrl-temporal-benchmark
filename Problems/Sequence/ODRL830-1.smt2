; --------------------------------------------------------------------------
; File     : ODRL830-1.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : delays >= P5D,P5D within deadline P8D -> Conflict
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : ODRL830-1.smt2
; Status   : unsat
; Verdict  : Conflict
; Comments : Category: Sequence  Difficulty: Medium
; --------------------------------------------------------------------------

(set-logic QF_IDL)
(declare-const p0 Int)
(declare-const p1 Int)
(declare-const p2 Int)
(assert (<= p0 p1))
(assert (>= (- p1 p0) 5))
(assert (<= p1 p2))
(assert (>= (- p2 p1) 5))
(assert (<= (- p2 p0) 8))
(check-sat)
(exit)
