%--------------------------------------------------------------------------
% File     : ODRL863-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : BSB-BnF running example, four-operand verdict vector -> Conflict
% Version  : 1.0
% English  : The paper's BSB-BnF table as a verdict vector over [dateTime, elapsedTime, delayPeriod, timeInterval]
%           : = [conflict, compatible, unknown, conflict]: dateTime disjoint (2027-06-01 not < 2026-12-31),
%           : elapsedTime overlap [0,P10D], delayPeriod silent in the request (unknown), timeInterval disjoint cycles
%           : (gcd(30,45)=15 does not divide the 516-day offset). The and-fold over the four is Conflict.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL863-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : verdict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL863-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl863, conjecture,
    policy_verdict(policy_verdict(policy_verdict(conflict, compatible), unknown), conflict) = conflict).
%--------------------------------------------------------------------------
