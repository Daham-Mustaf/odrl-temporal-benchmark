%--------------------------------------------------------------------------
% File     : ODRL816-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : timeInterval eq P30D & eq P45D, aligned anchors -> Compatible
% Version  : 1.0
% English  : timeInterval eq P30D (anchor 2026-01-01) & eq P45D (anchor 2026-01-01).
%           : Offset 0; gcd(30,45)=15 divides 0, so the schedules coincide (e.g. day 90).
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL816-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : conflict
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL816-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl816, conjecture,
    ?[T:$int,K:$int,M:$int]: ($greatereq(K,0) & $greatereq(M,0) & T = $sum(0, $product(30, K)) & T = $sum(0, $product(45, M)))).
%--------------------------------------------------------------------------
