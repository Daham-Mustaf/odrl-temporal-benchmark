%--------------------------------------------------------------------------
% File     : ODRL858-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : completing another operand does not rescue a conflict (soundness)
% Version  : 1.0
% English  : Soundness (Thm. unknown-sound): ODRL850 had dateTime in conflict and elapsedTime silent (Unknown
%           : overall = Conflict). Completing elapsedTime compatibly leaves the dateTime conflict untouched:
%           : policy_verdict(conflict, compatible) = conflict. A definite Conflict is stable under completion.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL858-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : verdict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL858-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl858, conjecture,
    policy_verdict(conflict, compatible) = conflict).
%--------------------------------------------------------------------------
