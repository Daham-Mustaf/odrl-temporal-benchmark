%--------------------------------------------------------------------------
% File     : ODRL860-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : one conflicting operand dominates the and-fold -> Conflict
% Version  : 1.0
% English  : dateTime is disjoint (offer eq 2026-08-01 vs request eq 2027-01-01) while elapsedTime and delayPeriod are compatible; the and-fold is conflict (conflict is the Kleene bottom).
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL860-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : verdict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL860-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl860, conjecture,
    policy_verdict(policy_verdict(conflict, compatible), compatible) = conflict).
%--------------------------------------------------------------------------
