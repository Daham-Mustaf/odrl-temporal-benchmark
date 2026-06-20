%--------------------------------------------------------------------------
% File     : ODRL855-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : [i0,i10] does not refine [i5,i15] -> NotRefines
% Version  : 1.0
% English  : dateTime window [2026-01-01,2026-01-11] is NOT contained in [2026-01-06,2026-01-16] (lower 1 < 6). interval_subsumes fails. NotRefines.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL855-1.p
%
% Status   : Theorem
% Verdict  : NotRefines
% Relation : refinement
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL855-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(ord_i0_i5, axiom, less(i0, i5)).
fof(ord_i5_i10, axiom, less(i5, i10)).
fof(ord_i10_i15, axiom, less(i10, i15)).
fof(distinct, axiom, $distinct(i0, i5, i10, i15)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl855, conjecture,
    ~( interval_subsumes(i0, i10, i5, i15) )).
%--------------------------------------------------------------------------
