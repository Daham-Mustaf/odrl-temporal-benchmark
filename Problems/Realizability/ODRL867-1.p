%--------------------------------------------------------------------------
% File     : ODRL867-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : andSequence demands more delay than its own cap -> Unrealizable
% Version  : 1.0
% English  : One policy: an andSequence of two delayPeriod gteq P5D steps (>= 10 days of gaps) under a global
%           : elapsedTime lteq P8D cap. The sequence cannot complete within the cap (10 > 8), so the policy is
%           : internally unsatisfiable. STN: p1>=5, p2-p1>=5, p2<=8 is infeasible. Unrealizable.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies., 2026.
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL867-1.p
%
% Status   : Theorem
% Verdict  : Unrealizable
% Relation : realizability
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL867-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl867, conjecture,
    ![P1 : $int, P2 : $int] : ~( $greatereq(P1, 5) & $greatereq($difference(P2, P1), 5) & $lesseq(P2, 8) )).
%--------------------------------------------------------------------------
