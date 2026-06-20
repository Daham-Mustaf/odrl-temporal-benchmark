%--------------------------------------------------------------------------
% File     : ODRL817-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : timeInterval eq P30D & eq P45D, offset 1 -> Conflict
% Version  : 1.0
% English  : timeInterval eq P30D (anchor day 0) & eq P45D (anchor day 1).
%           : Offset 1; gcd(30,45)=15 does not divide 1, so the schedules never coincide.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL817-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : conflict
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL817-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl817, conjecture,
    ![T:$int,K:$int,M:$int]: ~($greatereq(K,0) & $greatereq(M,0) & T = $sum(0, $product(30, K)) & T = $sum(1, $product(45, M)))).
%--------------------------------------------------------------------------
