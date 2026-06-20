%--------------------------------------------------------------------------
% File     : ODRL843-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : or(dateTime gteq 2026-06-01, gteq 2026-08-01) vs eq 2026-04-01 -> Conflict
% Version  : 1.0
% English  : Offer 2026-04-01 satisfies neither gteq branch (Apr precedes Jun), so the union excludes it. Conflict.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL843-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL843-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(ord_apr1_jun1, axiom, less(apr1, jun1)).
fof(ord_jun1_aug1, axiom, less(jun1, aug1)).
fof(distinct, axiom, $distinct(apr1, jun1, aug1)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl843, conjecture,
    ![X]: ~(X = apr1 & (leq(jun1, X) | leq(aug1, X)))).
%--------------------------------------------------------------------------
