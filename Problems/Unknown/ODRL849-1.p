%--------------------------------------------------------------------------
% File     : ODRL849-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : compatible operand + silent operand -> Unknown
% Version  : 1.0
% English  : elapsedTime is constrained by both (offer lteq P10D, request lteq P5D; overlap -> compatible),
%           : but delayPeriod is constrained only by the offer (request silent -> unknown). Kleene min:
%           : policy_verdict(compatible, unknown) = unknown. The pair is underdetermined, not a conflict.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL849-1.p
%
% Status   : Theorem
% Verdict  : Unknown
% Relation : verdict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL849-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl849, conjecture,
    policy_verdict(compatible, unknown) = unknown).
%--------------------------------------------------------------------------
