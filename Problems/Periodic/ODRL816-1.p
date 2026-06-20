%--------------------------------------------------------------------------
% File     : ODRL816-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : timeInterval eq P30D & eq P45D, aligned anchors -> Compatible
% Version  : 1.0
% English  : timeInterval eq P30D (anchor 2026-01-01) & eq P45D (anchor 2026-01-01).
%           : Offset 0; gcd(30,45)=15 divides 0, so the schedules coincide (e.g. day 90).
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL816-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : conflict
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL816-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl816, conjecture,
    ?[T:$int,K:$int,M:$int]: ($greatereq(K,0) & $greatereq(M,0) & T = $sum(0, $product(30, K)) & T = $sum(0, $product(45, M)))).
%--------------------------------------------------------------------------
