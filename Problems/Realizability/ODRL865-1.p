%--------------------------------------------------------------------------
% File     : ODRL865-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : single policy with an empty dateTime window -> Unrealizable
% Version  : 1.0
% English  : One party's rule requires dateTime gteq 2026-06-01 and dateTime lt 2026-03-01; the lower bound is after the upper bound, so no instant satisfies the policy. Unrealizable.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL865-1.p
%
% Status   : Theorem
% Verdict  : Unrealizable
% Relation : realizability
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL865-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(ord_mar1_jun1, axiom, less(mar1, jun1)).
fof(distinct, axiom, $distinct(mar1, jun1)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl865, conjecture,
    ![X] : ~( leq(jun1, X) & less(X, mar1) )).
%--------------------------------------------------------------------------
