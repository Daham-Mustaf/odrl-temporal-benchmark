%--------------------------------------------------------------------------
% File     : ODRL850-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : conflict operand dominates a silent operand -> Conflict
% Version  : 1.0
% English  : dateTime is constrained by both and disjoint (offer eq 2026-08-01, request eq 2027-01-01 ->
%           : conflict); elapsedTime only by the offer (-> unknown). Kleene min, conflict is bottom:
%           : policy_verdict(conflict, unknown) = conflict. A real conflict overrides the indeterminacy.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL850-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : verdict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL850-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl850, conjecture,
    policy_verdict(conflict, unknown) = conflict).
%--------------------------------------------------------------------------
