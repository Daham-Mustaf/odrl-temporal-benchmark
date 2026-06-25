%--------------------------------------------------------------------------
% File     : ODRL856-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : complete a silent operand compatibly: Unknown -> Compatible
% Version  : 1.0
% English  : Completes ODRL849: the request now constrains delayPeriod (gteq P2D), overlapping the offer's
%           : gteq P1D, so that operand resolves to compatible. With elapsedTime also compatible,
%           : policy_verdict(compatible, compatible) = compatible. The Unknown is resolved upward.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL856-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : verdict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL856-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl856, conjecture,
    policy_verdict(compatible, compatible) = compatible).
%--------------------------------------------------------------------------
