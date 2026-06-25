%--------------------------------------------------------------------------
% File     : ODRL835-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : [i0,i10] vs (i10,i20], second open at i10 -> Conflict
% Version  : 1.0
% English  : dateTime in [i0,i10] (closed upper) vs (i10,i20] (OPEN lower, via gt). The second
%           : excludes i10: prec(i10,i10,c,o) <=> leq(i10,i10) is TRUE. Disjoint -> Conflict.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL835-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
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
