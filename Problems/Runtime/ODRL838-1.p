%--------------------------------------------------------------------------
% File     : ODRL838-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : metered cap exceeded (metered 7 > P5D) -> Conflict
% Version  : 1.0
% English  : metered=3+4=7 violates meteredTime lteq P5D (7<=5 fails). Runtime conflict.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies., 2026.
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL838-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : runtime
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL838-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl838, conjecture,
    ~($lesseq(8, 10) & $lesseq(7, 5))).
%--------------------------------------------------------------------------
