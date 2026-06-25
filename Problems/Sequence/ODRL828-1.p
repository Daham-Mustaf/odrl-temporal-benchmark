%--------------------------------------------------------------------------
% File     : ODRL828-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : delay >= P5D within elapsed deadline P3D -> Conflict
% Version  : 1.0
% English  : Provider step delayPeriod gteq P5D forces span >= 5; consumer elapsedTime
%           : lteq P3D forces span <= 3. 5 <= span <= 3 is a negative cycle. Conflict.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL828-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : conflict
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL828-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl828, conjecture,
    ![p0:$int,p1:$int]: ~($lesseq(p0,p1) & $greatereq($difference(p1,p0),5) & $lesseq($difference(p1,p0),3))).
%--------------------------------------------------------------------------
