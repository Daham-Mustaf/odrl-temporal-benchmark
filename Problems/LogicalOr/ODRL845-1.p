%--------------------------------------------------------------------------
% File     : ODRL845-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : or(dateTime gteq 2026-06-01, gteq 2026-08-01) vs eq 2026-07-01 -> Compatible
% Version  : 1.0
% English  : Offer 2026-07-01 satisfies the first branch (>= Jun) but not the second; the union includes it. Compatible.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL845-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL845-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(ord_jun1_jul1, axiom, less(jun1, jul1)).
fof(ord_jul1_aug1, axiom, less(jul1, aug1)).
fof(distinct, axiom, $distinct(jun1, jul1, aug1)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl845, conjecture,
    ?[X]: (X = jul1 & (leq(jun1, X) | leq(aug1, X)))).
%--------------------------------------------------------------------------
