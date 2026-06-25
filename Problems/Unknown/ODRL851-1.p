%--------------------------------------------------------------------------
% File     : ODRL851-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : two silent operands -> Unknown
% Version  : 1.0
% English  : Each operand is constrained by only one side: elapsedTime only by the offer, delayPeriod only
%           : by the request. Both per-operand verdicts are unknown, so policy_verdict(unknown, unknown) =
%           : unknown. Nothing forces a conflict and nothing is jointly pinned.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL851-1.p
%
% Status   : Theorem
% Verdict  : Unknown
% Relation : verdict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL851-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl851, conjecture,
    policy_verdict(unknown, unknown) = unknown).
%--------------------------------------------------------------------------
