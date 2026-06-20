%--------------------------------------------------------------------------
% File     : ODRL821-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : meteredTime eq P20D & elapsedTime lteq P10D -> Conflict (via Phi)
% Version  : 1.0
% English  : meteredTime eq P20D (me=20) & elapsedTime lteq P10D (el<=10).
%           : Phi forces me <= el, so 20 <= el <= 10 is impossible. Conflict.
%           : Without Phi the two would be jointly satisfiable (Compatible).
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL821-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : conflict
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL821-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl821, conjecture,
    ![ME:$int,EL:$int]: ~($greatereq(ME,0) & $greatereq(EL,0) & $lesseq(ME,EL) & ME = 20 & $lesseq(EL,10))).
%--------------------------------------------------------------------------
