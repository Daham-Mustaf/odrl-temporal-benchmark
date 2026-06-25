%--------------------------------------------------------------------------
% File     : ODRL818-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : timeInterval eq P30D & eq P30D, offset 15 -> Conflict
% Version  : 1.0
% English  : timeInterval eq P30D (anchor day 0) & eq P30D (anchor day 15).
%           : Same period 30, offset 15; 30 does not divide 15, so the cycles never align.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL818-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : conflict
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL818-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl818, conjecture,
    ![T:$int,K:$int,M:$int]: ~($greatereq(K,0) & $greatereq(M,0) & T = $sum(0, $product(30, K)) & T = $sum(15, $product(30, M)))).
%--------------------------------------------------------------------------
