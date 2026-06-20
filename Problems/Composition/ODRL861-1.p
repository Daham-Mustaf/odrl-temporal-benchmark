%--------------------------------------------------------------------------
% File     : ODRL861-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : one silent operand makes the and-fold Unknown
% Version  : 1.0
% English  : dateTime and elapsedTime are compatible; delayPeriod is constrained only by the offer (request silent) so it is unknown; with no conflict the and-fold is unknown.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL861-1.p
%
% Status   : Theorem
% Verdict  : Unknown
% Relation : verdict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL861-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl861, conjecture,
    policy_verdict(policy_verdict(compatible, compatible), unknown) = unknown).
%--------------------------------------------------------------------------
