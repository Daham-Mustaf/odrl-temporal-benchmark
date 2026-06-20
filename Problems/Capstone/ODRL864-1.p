%--------------------------------------------------------------------------
% File     : ODRL864-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : BSB-BnF structure with conflicts resolved -> Unknown
% Version  : 1.0
% English  : Same four-operand structure with the two conflicts removed: dateTime aligned (both eq 2026-06-01),
%           : timeInterval aligned (both eq P30D, shared anchor), elapsedTime overlap, delayPeriod still silent in
%           : the request. The vector is [compatible, compatible, unknown, compatible], so the and-fold is Unknown
%           : -- a single silent operand keeps the whole policy pair underdetermined.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL864-1.p
%
% Status   : Theorem
% Verdict  : Unknown
% Relation : verdict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL864-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl864, conjecture,
    policy_verdict(policy_verdict(policy_verdict(compatible, compatible), unknown), compatible) = unknown).
%--------------------------------------------------------------------------
