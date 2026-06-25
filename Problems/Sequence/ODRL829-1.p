%--------------------------------------------------------------------------
% File     : ODRL829-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : delays >= P5D,P5D within deadline P12D -> Compatible
% Version  : 1.0
% English  : Provider andSequence delayPeriod gteq P5D then gteq P5D forces span >= 10;
%           : consumer elapsedTime lteq P12D. 10 <= 12 fits. Compatible.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL829-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : conflict
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL829-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl829, conjecture,
    ?[p0:$int,p1:$int,p2:$int]: ($lesseq(p0,p1) & $greatereq($difference(p1,p0),5) & $lesseq(p1,p2) & $greatereq($difference(p2,p1),5) & $lesseq($difference(p2,p0),12))).
%--------------------------------------------------------------------------
