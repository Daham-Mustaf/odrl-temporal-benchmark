%--------------------------------------------------------------------------
% File     : ODRL841-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : delay satisfied (delay 2 >= P1D) -> Compatible
% Version  : 1.0
% English  : delay=now-trig=2 satisfies delayPeriod gteq P1D (2>=1). Compatible.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL841-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : runtime
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL841-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl841, conjecture,
    ($greatereq(2, 1))).
%--------------------------------------------------------------------------
