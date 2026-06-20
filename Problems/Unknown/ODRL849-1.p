%--------------------------------------------------------------------------
% File     : ODRL849-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : compatible operand + silent operand -> Unknown
% Version  : 1.0
% English  : elapsedTime is constrained by both (offer lteq P10D, request lteq P5D; overlap -> compatible),
%           : but delayPeriod is constrained only by the offer (request silent -> unknown). Kleene min:
%           : policy_verdict(compatible, unknown) = unknown. The pair is underdetermined, not a conflict.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL849-1.p
%
% Status   : Theorem
% Verdict  : Unknown
% Relation : verdict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL849-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl849, conjecture,
    policy_verdict(compatible, unknown) = unknown).
%--------------------------------------------------------------------------
