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
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL820-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : conflict
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL820-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl820, conjecture,
    ![T:$int,K:$int,M:$int]: ~($greatereq(K,0) & $greatereq(M,0) & T = $sum(0, $product(30, K)) & T = $sum(516, $product(45, M)))).
%--------------------------------------------------------------------------
