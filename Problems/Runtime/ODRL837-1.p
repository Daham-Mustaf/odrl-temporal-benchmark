%--------------------------------------------------------------------------
% File     : ODRL837-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : compliant execution (elapsed 8, metered 5) -> Compatible
% Version  : 1.0
% English  : elapsed=now-start=8<=10 and metered=2+3=5<=5: execution complies. Compatible.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies., 2026.
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL837-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : runtime
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL837-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl837, conjecture,
    ($lesseq(8, 10) & $lesseq(5, 5))).
%--------------------------------------------------------------------------
