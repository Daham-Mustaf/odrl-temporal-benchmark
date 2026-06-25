%--------------------------------------------------------------------------
% File     : ODRL840-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : statically Compatible, runtime Conflict (metered 9 > min cap P8D)
% Version  : 1.0
% English  : C1 cap P10D and C2 cap P8D are statically Compatible, but metered=4+5=9 violates C2 (9<=8 fails). Thm. static-runtime.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL840-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : runtime
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL840-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl840, conjecture,
    ~($lesseq(9, 10) & $lesseq(9, 8))).
%--------------------------------------------------------------------------
