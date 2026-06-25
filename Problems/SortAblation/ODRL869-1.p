%--------------------------------------------------------------------------
% File     : ODRL869-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : naive unsorted reading collapses instant and duration -> spurious Conflict
% Version  : 1.0
% English  : WITHOUT sort stratification the instant 2026-12-01 (day 334) and the duration P30D (30) are placed on
%           : one axis via less(dur30, inst334); the offer's dateTime gteq day334 and the request's elapsedTime lteq
%           : 30 then require a single point with 334 <= X <= 30, which is impossible. The naive engine reports a
%           : Conflict that is not real: the operands never shared a domain to begin with.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL869-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : sort-ablation
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL869-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(cross_sort, axiom, less(dur30, inst334)).
fof(distinct, axiom, $distinct(dur30, inst334)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl869, conjecture,
    ![X] : ~( leq(inst334, X) & leq(X, dur30) )).
%--------------------------------------------------------------------------
