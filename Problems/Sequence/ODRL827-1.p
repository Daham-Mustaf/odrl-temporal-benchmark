%--------------------------------------------------------------------------
% File     : ODRL827-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : delay >= P3D within elapsed deadline P5D -> Compatible
% Version  : 1.0
% English  : Provider andSequence with one step delayPeriod gteq P3D (>=3 after start);
%           : consumer elapsedTime lteq P5D. 3 <= span <= 5 is satisfiable. Compatible.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL827-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : conflict
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL827-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl827, conjecture,
    ?[p0:$int,p1:$int]: ($lesseq(p0,p1) & $greatereq($difference(p1,p0),3) & $lesseq($difference(p1,p0),5))).
%--------------------------------------------------------------------------
