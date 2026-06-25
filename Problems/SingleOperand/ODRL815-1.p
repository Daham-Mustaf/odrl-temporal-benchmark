%--------------------------------------------------------------------------
% File     : ODRL815-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : meteredTime eq P10D & lt P10D -> Conflict
% Version  : 1.0
% English  : meteredTime: eq P10D -> {10}   lt P10D -> [0,10)
%           : 10 is not strictly less than 10, so {10} is outside [0,10). Conflict.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL815-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL815-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DUR000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(dur_d0, axiom, dur(d0)).
fof(dur_p10, axiom, dur(p10)).
fof(ord_d0_p10, axiom, less(d0, p10)).
fof(distinct, axiom, $distinct(d0, p10)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl815, conjecture,
    ![X]: ~(in_closed(X, p10, p10) & in_ropen(X, d0, p10))).
%--------------------------------------------------------------------------
