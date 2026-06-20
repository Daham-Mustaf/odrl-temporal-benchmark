%--------------------------------------------------------------------------
% File     : ODRL857-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : complete a silent operand incompatibly: Unknown -> Conflict
% Version  : 1.0
% English  : Completes ODRL849 the other way: the request pins delayPeriod eq P1D, below the offer's gteq P5D
%           : floor, so that operand resolves to conflict. policy_verdict(compatible, conflict) = conflict.
%           : The same Unknown operand can complete to either verdict; the added constraint decides.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL857-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : verdict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL857-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl857, conjecture,
    policy_verdict(compatible, conflict) = conflict).
%--------------------------------------------------------------------------
