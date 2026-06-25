%--------------------------------------------------------------------------
% File     : ODRL800-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : dateTime lteq 2026-12-31 & gteq 2027-06-01 -> Conflict
% Version  : 1.0
% English  : dateTime: lteq 2026-12-31 -> (-inf,t2]   gteq 2027-06-01 -> [t3,+inf)
%           : t2 < t3 so the bounds cross: no instant satisfies both. Conflict.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL800-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL800-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(ord_t2_t3, axiom, less(d20261231, d20270601)).
fof(distinct,  axiom, $distinct(d20261231, d20270601)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl800, conjecture,
    ![X]: ~(leq(X, d20261231) & leq(d20270601, X))).
%--------------------------------------------------------------------------
