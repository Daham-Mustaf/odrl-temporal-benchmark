%--------------------------------------------------------------------------
% File     : ODRL840-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : statically Compatible, runtime Conflict (metered 9 > min cap P8D)
% Version  : 1.0
% English  : C1 cap P10D and C2 cap P8D are statically Compatible, but metered=4+5=9 violates C2 (9<=8 fails). Thm. static-runtime.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL840-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : runtime
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL840-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl840, conjecture,
    ~($lesseq(9, 10) & $lesseq(9, 8))).
%--------------------------------------------------------------------------
