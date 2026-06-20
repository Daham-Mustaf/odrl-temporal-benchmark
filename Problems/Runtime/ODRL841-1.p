%--------------------------------------------------------------------------
% File     : ODRL841-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : delay satisfied (delay 2 >= P1D) -> Compatible
% Version  : 1.0
% English  : delay=now-trig=2 satisfies delayPeriod gteq P1D (2>=1). Compatible.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL841-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : runtime
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL841-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl841, conjecture,
    ($greatereq(2, 1))).
%--------------------------------------------------------------------------
