%--------------------------------------------------------------------------
% File     : ODRL842-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : delay too short (delay 0 < P1D) -> Conflict
% Version  : 1.0
% English  : delay=now-trig=0 violates delayPeriod gteq P1D (0>=1 fails). Runtime conflict.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL842-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : runtime
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL842-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl842, conjecture,
    ~($greatereq(0, 1))).
%--------------------------------------------------------------------------
