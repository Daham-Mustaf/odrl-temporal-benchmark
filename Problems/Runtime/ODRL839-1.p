%--------------------------------------------------------------------------
% File     : ODRL839-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : elapsed cap exceeded (elapsed 13 > P10D) -> Conflict
% Version  : 1.0
% English  : elapsed=now-start=13 violates elapsedTime lteq P10D (13<=10 fails). Runtime conflict.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL839-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : runtime
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL839-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl839, conjecture,
    ~($lesseq(13, 10) & $lesseq(5, 5))).
%--------------------------------------------------------------------------
