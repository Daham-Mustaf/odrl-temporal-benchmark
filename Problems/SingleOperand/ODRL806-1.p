%--------------------------------------------------------------------------
% File     : ODRL806-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : elapsedTime eq P600D & lteq P300D -> Conflict
% Version  : 1.0
% English  : elapsedTime: eq P600D -> {600}   lteq P300D -> [0,300]
%           : 600 > 300 so {600} is outside [0,300]. Conflict.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL806-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL806-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DUR000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(dur_d0,   axiom, dur(d0)).
fof(dur_p300, axiom, dur(p300)).
fof(dur_p600, axiom, dur(p600)).
fof(ord_d0_p300,   axiom, less(d0, p300)).
fof(ord_d0_p600,   axiom, less(d0, p600)).
fof(ord_p300_p600, axiom, less(p300, p600)).
fof(distinct, axiom, $distinct(d0, p300, p600)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl806, conjecture,
    ![X]: ~(in_closed(X, p600, p600) & in_closed(X, d0, p300))).
%--------------------------------------------------------------------------
