; --------------------------------------------------------------------------
; File     : DENOT000-0.smt2
; Domain   : ODRL Policy / Temporal Decomposition
; Problem  : Constraint denotation (realised directly in Real)
; Version  : 1.0
; Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
; Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
; Authors  : Mustafa, D.
; Names    : DENOT000-0.smt2
; Status   : sat
; Comments : Operators map to Real relations inline; conflict = unsat, compatible = sat.
; --------------------------------------------------------------------------
; Interval membership over Real (instants / durations); mirrors TPTP in_* names.
(define-fun in_open   ((x Real)(l Real)(u Real)) Bool (and (< l x) (< x u)))
(define-fun in_lopen  ((x Real)(l Real)(u Real)) Bool (and (< l x) (<= x u)))
(define-fun in_ropen  ((x Real)(l Real)(u Real)) Bool (and (<= l x) (< x u)))
(define-fun in_closed ((x Real)(l Real)(u Real)) Bool (and (<= l x) (<= x u)))
; Verdict is decided by the problem status: unsat = Conflict, sat = Compatible.
; The three-valued algebra (Unknown) is encoded per-problem where it arises.
