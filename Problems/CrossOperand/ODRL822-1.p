%--------------------------------------------------------------------------
% File     : ODRL822-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : meteredTime eq P5D & elapsedTime lteq P10D -> Compatible
% Version  : 1.0
% English  : meteredTime eq P5D (me=5) & elapsedTime lteq P10D (el<=10).
%           : Phi (me <= el) holds with el in [5,10]. Compatible (witness me=5, el=10).
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL822-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : conflict
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL822-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl822, conjecture,
    ?[ME:$int,EL:$int]: ($greatereq(ME,0) & $greatereq(EL,0) & $lesseq(ME,EL) & ME = 5 & $lesseq(EL,10))).
%--------------------------------------------------------------------------
