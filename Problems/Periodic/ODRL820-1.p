%--------------------------------------------------------------------------
% File     : ODRL820-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : timeInterval eq P30D & eq P45D, BSB-BnF offset 516 -> Conflict
% Version  : 1.0
% English  : BSB-BnF timeInterval layer: eq P30D (anchor 2026-01-01) & eq P45D
%           : (anchor 2027-06-01 = day 516). gcd(30,45)=15, 516 mod 15 = 6, so 15 does not
%           : divide 516: the recurring schedules never coincide. The periodic layer alone
%           : already conflicts.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL820-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : conflict
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL820-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl820, conjecture,
    ![T:$int,K:$int,M:$int]: ~($greatereq(K,0) & $greatereq(M,0) & T = $sum(0, $product(30, K)) & T = $sum(516, $product(45, M)))).
%--------------------------------------------------------------------------
