%--------------------------------------------------------------------------
% File     : ODRL868-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : andSequence fits within its cap -> Realizable
% Version  : 1.0
% English  : Same policy with the cap relaxed to elapsedTime lteq P12D. The two P5D gaps fit (10 <= 12), so a
%           : valid schedule exists (e.g. p1=5, p2=10). STN: p1>=5, p2-p1>=5, p2<=12 is feasible. Realizable.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies., 2026.
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL868-1.p
%
% Status   : Theorem
% Verdict  : Realizable
% Relation : realizability
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL868-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl868, conjecture,
    ?[P1 : $int, P2 : $int] : ( $greatereq(P1, 5) & $greatereq($difference(P2, P1), 5) & $lesseq(P2, 12) )).
%--------------------------------------------------------------------------
