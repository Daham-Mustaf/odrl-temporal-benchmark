%--------------------------------------------------------------------------
% File     : ODRL819-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : timeInterval eq P30D & eq P30D, offset 60 -> Compatible
% Version  : 1.0
% English  : timeInterval eq P30D (anchor day 0) & eq P30D (anchor day 60).
%           : Same period 30, offset 60; 30 divides 60, so the cycles coincide (e.g. day 60).
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL819-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : conflict
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL819-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl819, conjecture,
    ?[T:$int,K:$int,M:$int]: ($greatereq(K,0) & $greatereq(M,0) & T = $sum(0, $product(30, K)) & T = $sum(60, $product(30, M)))).
%--------------------------------------------------------------------------
