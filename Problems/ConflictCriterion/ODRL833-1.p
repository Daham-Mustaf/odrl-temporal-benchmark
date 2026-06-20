%--------------------------------------------------------------------------
% File     : ODRL833-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : [i0,i10] vs [i10,i20], both closed at i10 -> Compatible
% Version  : 1.0
% English  : dateTime in [i0,i10] (closed upper) vs [i10,i20] (closed lower). They meet at
%           : i10 and both include it: prec(i10,i10,c,c) <=> less(i10,i10) is FALSE. The
%           : instant i10 is shared -> not disjoint -> Compatible.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL833-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL833-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/PREC000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(ord_i0_i10, axiom, less(i0, i10)).
fof(ord_i0_i20, axiom, less(i0, i20)).
fof(ord_i10_i20, axiom, less(i10, i20)).
fof(distinct, axiom, $distinct(i0, i10, i20)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl833, conjecture,
    ~( disjoint(i0, i10, c, c, i10, i20, c, c) )).
%--------------------------------------------------------------------------
