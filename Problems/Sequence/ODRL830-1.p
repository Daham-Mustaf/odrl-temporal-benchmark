%--------------------------------------------------------------------------
% File     : ODRL830-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : delays >= P5D,P5D within deadline P8D -> Conflict
% Version  : 1.0
% English  : Provider andSequence delayPeriod gteq P5D then gteq P5D forces span >= 10,
%           : but consumer elapsedTime lteq P8D forces span <= 8. 10 <= 8: negative cycle. Conflict.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL830-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : conflict
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL830-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl830, conjecture,
    ![p0:$int,p1:$int,p2:$int]: ~($lesseq(p0,p1) & $greatereq($difference(p1,p0),5) & $lesseq(p1,p2) & $greatereq($difference(p2,p1),5) & $lesseq($difference(p2,p0),8))).
%--------------------------------------------------------------------------
