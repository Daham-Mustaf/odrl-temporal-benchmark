%--------------------------------------------------------------------------
% File     : ODRL852-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : [i0,i5] refines [i0,i10] -> Refines
% Version  : 1.0
% English  : dateTime window [2026-01-01,2026-01-06] is contained in [2026-01-01,2026-01-11] (same lower, tighter upper). interval_subsumes holds. Refines.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL852-1.p
%
% Status   : Theorem
% Verdict  : Refines
% Relation : refinement
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL852-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(ord_i0_i5, axiom, less(i0, i5)).
fof(ord_i5_i10, axiom, less(i5, i10)).
fof(distinct, axiom, $distinct(i0, i5, i10)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl852, conjecture,
    interval_subsumes(i0, i5, i0, i10)).
%--------------------------------------------------------------------------
