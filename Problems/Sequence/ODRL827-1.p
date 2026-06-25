%--------------------------------------------------------------------------
% File     : ODRL827-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : delay >= P3D within elapsed deadline P5D -> Compatible
% Version  : 1.0
% English  : Provider andSequence with one step delayPeriod gteq P3D (>=3 after start);
%           : consumer elapsedTime lteq P5D. 3 <= span <= 5 is satisfiable. Compatible.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL827-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : conflict
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL827-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl827, conjecture,
    ?[p0:$int,p1:$int]: ($lesseq(p0,p1) & $greatereq($difference(p1,p0),3) & $lesseq($difference(p1,p0),5))).
%--------------------------------------------------------------------------
