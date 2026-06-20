%--------------------------------------------------------------------------
% File     : ODRL856-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : complete a silent operand compatibly: Unknown -> Compatible
% Version  : 1.0
% English  : Completes ODRL849: the request now constrains delayPeriod (gteq P2D), overlapping the offer's
%           : gteq P1D, so that operand resolves to compatible. With elapsedTime also compatible,
%           : policy_verdict(compatible, compatible) = compatible. The Unknown is resolved upward.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL856-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : verdict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL856-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl856, conjecture,
    policy_verdict(compatible, compatible) = compatible).
%--------------------------------------------------------------------------
