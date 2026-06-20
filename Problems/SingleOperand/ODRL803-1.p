%--------------------------------------------------------------------------
% File     : ODRL803-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : dateTime gt 2026-06-01 & lt 2027-06-01 -> Compatible (open, density)
% Version  : 1.0
% English  : dateTime: gt 2026-06-01 -> (t1,+inf)   lt 2027-06-01 -> (-inf,t3)
%           : Open interval (t1,t3); a witness strictly between exists only by density.
%           : Requires ORD001-0.ax.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL803-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL803-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/ORD001-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(ord_t1_t3, axiom, less(d20260601, d20270601)).
fof(distinct,  axiom, $distinct(d20260601, d20270601)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl803, conjecture,
    ?[X]: (less(d20260601, X) & less(X, d20270601))).
%--------------------------------------------------------------------------
