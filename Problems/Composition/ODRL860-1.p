%--------------------------------------------------------------------------
% File     : ODRL860-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : one conflicting operand dominates the and-fold -> Conflict
% Version  : 1.0
% English  : dateTime is disjoint (offer eq 2026-08-01 vs request eq 2027-01-01) while elapsedTime and delayPeriod are compatible; the and-fold is conflict (conflict is the Kleene bottom).
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL860-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : verdict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL860-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl860, conjecture,
    policy_verdict(policy_verdict(conflict, compatible), compatible) = conflict).
%--------------------------------------------------------------------------
