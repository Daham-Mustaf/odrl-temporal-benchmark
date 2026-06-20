%--------------------------------------------------------------------------
% File     : ODRL822-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : meteredTime eq P5D & elapsedTime lteq P10D -> Compatible
% Version  : 1.0
% English  : meteredTime eq P5D (me=5) & elapsedTime lteq P10D (el<=10).
%           : Phi (me <= el) holds with el in [5,10]. Compatible (witness me=5, el=10).
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL822-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : conflict
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL822-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl822, conjecture,
    ?[ME:$int,EL:$int]: ($greatereq(ME,0) & $greatereq(EL,0) & $lesseq(ME,EL) & ME = 5 & $lesseq(EL,10))).
%--------------------------------------------------------------------------
