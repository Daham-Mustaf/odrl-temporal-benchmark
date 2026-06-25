%--------------------------------------------------------------------------
% File     : ODRL821-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : meteredTime eq P20D & elapsedTime lteq P10D -> Conflict (via Phi)
% Version  : 1.0
% English  : meteredTime eq P20D (me=20) & elapsedTime lteq P10D (el<=10).
%           : Phi forces me <= el, so 20 <= el <= 10 is impossible. Conflict.
%           : Without Phi the two would be jointly satisfiable (Compatible).
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL821-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : conflict
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL821-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl821, conjecture,
    ![ME:$int,EL:$int]: ~($greatereq(ME,0) & $greatereq(EL,0) & $lesseq(ME,EL) & ME = 20 & $lesseq(EL,10))).
%--------------------------------------------------------------------------
