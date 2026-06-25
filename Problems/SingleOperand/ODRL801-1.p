%--------------------------------------------------------------------------
% File     : ODRL801-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : dateTime gteq 2026-06-01 & lteq 2027-06-01 -> Compatible
% Version  : 1.0
% English  : dateTime: gteq 2026-06-01 -> [t1,+inf)   lteq 2027-06-01 -> (-inf,t3]
%           : [t1,t3] is non-empty (witness t1). Compatible.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL801-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL801-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(ord_t1_t3, axiom, less(d20260601, d20270601)).
fof(distinct,  axiom, $distinct(d20260601, d20270601)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl801, conjecture,
    ?[X]: (leq(d20260601, X) & leq(X, d20270601))).
%--------------------------------------------------------------------------
