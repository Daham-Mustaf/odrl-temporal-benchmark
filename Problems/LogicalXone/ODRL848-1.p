%--------------------------------------------------------------------------
% File     : ODRL848-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : xone(dateTime gteq 2026-06-01, gteq 2026-08-01) vs eq 2026-04-01 -> Conflict
% Version  : 1.0
% English  : Offer 2026-04-01 satisfies neither branch (zero, not exactly one). xone excludes it. Conflict.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL848-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL848-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(ord_apr1_jun1, axiom, less(apr1, jun1)).
fof(ord_jun1_aug1, axiom, less(jun1, aug1)).
fof(distinct, axiom, $distinct(apr1, jun1, aug1)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl848, conjecture,
    ![X]: ~(X = apr1 & ((leq(jun1, X) & ~(leq(aug1, X))) | (~(leq(jun1, X)) & leq(aug1, X))))).
%--------------------------------------------------------------------------
