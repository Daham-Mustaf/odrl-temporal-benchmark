%--------------------------------------------------------------------------
% File     : ODRL859-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : and over three compatible operands -> Compatible
% Version  : 1.0
% English  : Offer and request agree on all three operands (dateTime, elapsedTime, delayPeriod), so each per-operand verdict is compatible and the and-fold is compatible.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL859-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : verdict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL859-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl859, conjecture,
    policy_verdict(policy_verdict(compatible, compatible), compatible) = compatible).
%--------------------------------------------------------------------------
