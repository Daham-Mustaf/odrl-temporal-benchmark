%--------------------------------------------------------------------------
% File     : ODRL851-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : two silent operands -> Unknown
% Version  : 1.0
% English  : Each operand is constrained by only one side: elapsedTime only by the offer, delayPeriod only
%           : by the request. Both per-operand verdicts are unknown, so policy_verdict(unknown, unknown) =
%           : unknown. Nothing forces a conflict and nothing is jointly pinned.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL851-1.p
%
% Status   : Theorem
% Verdict  : Unknown
% Relation : verdict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL851-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl851, conjecture,
    policy_verdict(unknown, unknown) = unknown).
%--------------------------------------------------------------------------
