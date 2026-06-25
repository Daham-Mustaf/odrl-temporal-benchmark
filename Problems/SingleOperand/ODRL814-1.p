%--------------------------------------------------------------------------
% File     : ODRL814-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : meteredTime lt P10D & lteq P30D -> Compatible
% Version  : 1.0
% English  : meteredTime: lt P10D -> [0,10)   lteq P30D -> [0,30]
%           : [0,10) is non-empty (witness 0). Compatible.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL814-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL814-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DUR000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(dur_d0, axiom, dur(d0)).
fof(dur_p10, axiom, dur(p10)).
fof(dur_p30, axiom, dur(p30)).
fof(ord_d0_p10, axiom, less(d0, p10)).
fof(ord_d0_p30, axiom, less(d0, p30)).
fof(ord_p10_p30, axiom, less(p10, p30)).
fof(distinct, axiom, $distinct(d0, p10, p30)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl814, conjecture,
    ?[X]: (in_ropen(X, d0, p10) & in_closed(X, d0, p30))).
%--------------------------------------------------------------------------
