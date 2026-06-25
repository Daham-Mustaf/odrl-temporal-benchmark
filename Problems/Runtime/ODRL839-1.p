%--------------------------------------------------------------------------
% File     : ODRL839-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : elapsed cap exceeded (elapsed 13 > P10D) -> Conflict
% Version  : 1.0
% English  : elapsed=now-start=13 violates elapsedTime lteq P10D (13<=10 fails). Runtime conflict.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL839-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : runtime
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL839-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl839, conjecture,
    ~($lesseq(13, 10) & $lesseq(5, 5))).
%--------------------------------------------------------------------------
