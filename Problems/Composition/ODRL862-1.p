%--------------------------------------------------------------------------
% File     : ODRL862-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : conflict dominates an unknown in the and-fold -> Conflict
% Version  : 1.0
% English  : dateTime is disjoint (conflict), elapsedTime compatible, delayPeriod silent (unknown); conflict beats the unknown so the and-fold is conflict even with an unknown present.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL862-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : verdict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL862-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl862, conjecture,
    policy_verdict(policy_verdict(conflict, compatible), unknown) = conflict).
%--------------------------------------------------------------------------
