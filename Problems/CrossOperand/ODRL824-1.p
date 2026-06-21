%--------------------------------------------------------------------------
% File     : ODRL824-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : meteredTime lteq P10D & elapsedTime eq P20D -> Compatible
% Version  : 1.0
% English  : meteredTime lteq P10D (me<=10) & elapsedTime eq P20D (el=20).
%           : Phi (me <= el = 20) holds for any me <= 10. Compatible.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies., 2026.
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL824-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : conflict
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL824-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl824, conjecture,
    ?[ME:$int,EL:$int]: ($greatereq(ME,0) & $greatereq(EL,0) & $lesseq(ME,EL) & $lesseq(ME,10) & EL = 20)).
%--------------------------------------------------------------------------
