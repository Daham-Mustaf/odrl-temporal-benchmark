%--------------------------------------------------------------------------
% File     : ODRL854-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : [i5,i10] refines [i0,i15] -> Refines
% Version  : 1.0
% English  : dateTime window [2026-01-06,2026-01-11] is contained in [2026-01-01,2026-01-16] (both bounds inside). interval_subsumes holds. Refines.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL854-1.p
%
% Status   : Theorem
% Verdict  : Refines
% Relation : refinement
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL854-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(ord_i0_i5, axiom, less(i0, i5)).
fof(ord_i5_i10, axiom, less(i5, i10)).
fof(ord_i10_i15, axiom, less(i10, i15)).
fof(distinct, axiom, $distinct(i0, i5, i10, i15)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl854, conjecture,
    interval_subsumes(i5, i10, i0, i15)).
%--------------------------------------------------------------------------
