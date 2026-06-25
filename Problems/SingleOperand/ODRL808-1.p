%--------------------------------------------------------------------------
% File     : ODRL808-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : delayPeriod gteq P1D & gteq P5D -> Compatible
% Version  : 1.0
% English  : delayPeriod: gteq P1D -> [1,+inf)   gteq P5D -> [5,+inf)
%           : Two lower bounds; effective delay max(1,5)=5 is satisfiable. Compatible.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL808-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL808-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DUR000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(dur_d0, axiom, dur(d0)).
fof(dur_p1, axiom, dur(p1)).
fof(dur_p5, axiom, dur(p5)).
fof(ord_d0_p1, axiom, less(d0, p1)).
fof(ord_d0_p5, axiom, less(d0, p5)).
fof(ord_p1_p5, axiom, less(p1, p5)).
fof(distinct, axiom, $distinct(d0, p1, p5)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl808, conjecture,
    ?[X]: (leq(p1, X) & leq(p5, X))).
%--------------------------------------------------------------------------
