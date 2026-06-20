%--------------------------------------------------------------------------
% File     : ODRL870-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : sort-stratified reading keeps them incomparable -> no Conflict (Compatible)
% Version  : 1.0
% English  : WITH sort stratification the instant and the duration are in separate ordered domains (no cross-sort
%           : order fact), so the offer's dateTime constraint and the request's elapsedTime constraint are each
%           : satisfiable on their own axis (witnessed by inst334 and dur30 respectively) and never interact. The
%           : correct verdict is no conflict. This is the same policy pair as ODRL869; only the sort discipline differs.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL870-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : sort-ablation
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL870-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(distinct, axiom, $distinct(dur30, inst334)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl870, conjecture,
    leq(inst334, inst334) & leq(dur30, dur30)).
%--------------------------------------------------------------------------
