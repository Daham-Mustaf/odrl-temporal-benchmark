%--------------------------------------------------------------------------
% File     : ODRL832-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : [i0,i10] vs [i5,i15] -> Compatible (overlap)
% Version  : 1.0
% English  : dateTime in [i0,i10] vs [i5,i15]; overlap on [i5,i10]. Neither prec holds, so
%           : not disjoint -> Compatible.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL832-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
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
