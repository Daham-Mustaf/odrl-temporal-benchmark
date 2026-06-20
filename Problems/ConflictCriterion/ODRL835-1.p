%--------------------------------------------------------------------------
% File     : ODRL835-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : [i0,i10] vs (i10,i20], second open at i10 -> Conflict
% Version  : 1.0
% English  : dateTime in [i0,i10] (closed upper) vs (i10,i20] (OPEN lower, via gt). The second
%           : excludes i10: prec(i10,i10,c,o) <=> leq(i10,i10) is TRUE. Disjoint -> Conflict.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL835-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL835-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/PREC000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(ord_i0_i10, axiom, less(i0, i10)).
fof(ord_i0_i20, axiom, less(i0, i20)).
fof(ord_i10_i20, axiom, less(i10, i20)).
fof(distinct, axiom, $distinct(i0, i10, i20)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl835, conjecture,
    disjoint(i0, i10, c, c, i10, i20, o, c)).
%--------------------------------------------------------------------------
