%--------------------------------------------------------------------------
% File     : ODRL805-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : elapsedTime lteq P1200D & eq P600D -> Compatible
% Version  : 1.0
% English  : elapsedTime: lteq P1200D -> [0,1200]   eq P600D -> {600}
%           : 600 <= 1200 so the required point lies within the cap. Compatible.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL805-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL805-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DUR000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(dur_d0,    axiom, dur(d0)).
fof(dur_p600,  axiom, dur(p600)).
fof(dur_p1200, axiom, dur(p1200)).
fof(ord_d0_p600,    axiom, less(d0, p600)).
fof(ord_d0_p1200,   axiom, less(d0, p1200)).
fof(ord_p600_p1200, axiom, less(p600, p1200)).
fof(distinct, axiom, $distinct(d0, p600, p1200)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl805, conjecture,
    ?[X]: (in_closed(X, d0, p1200) & in_closed(X, p600, p600))).
%--------------------------------------------------------------------------
