%--------------------------------------------------------------------------
% File     : ODRL832-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : [i0,i10] vs [i5,i15] -> Compatible (overlap)
% Version  : 1.0
% English  : dateTime in [i0,i10] vs [i5,i15]; overlap on [i5,i10]. Neither prec holds, so
%           : not disjoint -> Compatible.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL832-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL832-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/PREC000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(ord_i0_i5, axiom, less(i0, i5)).
fof(ord_i0_i10, axiom, less(i0, i10)).
fof(ord_i0_i15, axiom, less(i0, i15)).
fof(ord_i5_i10, axiom, less(i5, i10)).
fof(ord_i5_i15, axiom, less(i5, i15)).
fof(ord_i10_i15, axiom, less(i10, i15)).
fof(distinct, axiom, $distinct(i0, i5, i10, i15)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl832, conjecture,
    ~( disjoint(i0, i10, c, c, i5, i15, c, c) )).
%--------------------------------------------------------------------------
