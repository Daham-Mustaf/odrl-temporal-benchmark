%--------------------------------------------------------------------------
% File     : ODRL846-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : xone(dateTime gteq 2026-06-01, gteq 2026-08-01) vs eq 2026-09-01 -> Conflict
% Version  : 1.0
% English  : Offer 2026-09-01 satisfies BOTH gteq branches, so exactly-one fails. xone excludes it (vs ODRL844 or). Conflict.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL846-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL846-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(ord_jun1_aug1, axiom, less(jun1, aug1)).
fof(ord_aug1_sep1, axiom, less(aug1, sep1)).
fof(distinct, axiom, $distinct(jun1, aug1, sep1)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl846, conjecture,
    ![X]: ~(X = sep1 & ((leq(jun1, X) & ~(leq(aug1, X))) | (~(leq(jun1, X)) & leq(aug1, X))))).
%--------------------------------------------------------------------------
