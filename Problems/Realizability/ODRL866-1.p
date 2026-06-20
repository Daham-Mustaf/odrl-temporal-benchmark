%--------------------------------------------------------------------------
% File     : ODRL866-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : single policy with a proper dateTime window -> Realizable
% Version  : 1.0
% English  : One party's rule requires dateTime gteq 2026-03-01 and dateTime lt 2026-06-01; the window is non-empty (the lower bound itself satisfies it), so the policy is satisfiable. Realizable.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL866-1.p
%
% Status   : Theorem
% Verdict  : Realizable
% Relation : realizability
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL866-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(ord_mar1_jun1, axiom, less(mar1, jun1)).
fof(distinct, axiom, $distinct(mar1, jun1)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl866, conjecture,
    leq(mar1, mar1) & less(mar1, jun1)).
%--------------------------------------------------------------------------
