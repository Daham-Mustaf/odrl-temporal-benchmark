%--------------------------------------------------------------------------
% File     : ODRL846-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : xone(dateTime gteq 2026-06-01, gteq 2026-08-01) vs eq 2026-09-01 -> Conflict
% Version  : 1.0
% English  : Offer 2026-09-01 satisfies BOTH gteq branches, so exactly-one fails. xone excludes it (vs ODRL844 or). Conflict.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL846-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
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
