%--------------------------------------------------------------------------
% File     : ODRL853-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : [i0,i20] does not refine [i0,i10] -> NotRefines
% Version  : 1.0
% English  : dateTime window [2026-01-01,2026-01-21] is NOT contained in [2026-01-01,2026-01-11] (upper 21 > 11). interval_subsumes fails. NotRefines.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL853-1.p
%
% Status   : Theorem
% Verdict  : NotRefines
% Relation : refinement
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL853-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(ord_i0_i10, axiom, less(i0, i10)).
fof(ord_i10_i20, axiom, less(i10, i20)).
fof(distinct, axiom, $distinct(i0, i10, i20)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl853, conjecture,
    ~( interval_subsumes(i0, i20, i0, i10) )).
%--------------------------------------------------------------------------
