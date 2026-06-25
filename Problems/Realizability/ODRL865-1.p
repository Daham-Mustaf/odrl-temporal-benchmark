%--------------------------------------------------------------------------
% File     : ODRL865-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : single policy with an empty dateTime window -> Unrealizable
% Version  : 1.0
% English  : One party's rule requires dateTime gteq 2026-06-01 and dateTime lt 2026-03-01; the lower bound is after the upper bound, so no instant satisfies the policy. Unrealizable.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL865-1.p
%
% Status   : Theorem
% Verdict  : Unrealizable
% Relation : realizability
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
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
