%--------------------------------------------------------------------------
% File     : ODRL819-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : timeInterval eq P30D & eq P30D, offset 60 -> Compatible
% Version  : 1.0
% English  : timeInterval eq P30D (anchor day 0) & eq P30D (anchor day 60).
%           : Same period 30, offset 60; 30 divides 60, so the cycles coincide (e.g. day 60).
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL819-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : conflict
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL819-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl819, conjecture,
    ?[T:$int,K:$int,M:$int]: ($greatereq(K,0) & $greatereq(M,0) & T = $sum(0, $product(30, K)) & T = $sum(60, $product(30, M)))).
%--------------------------------------------------------------------------
