%--------------------------------------------------------------------------
% File     : ODRL810-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : delayPeriod eq P5D & gteq P1D -> Compatible
% Version  : 1.0
% English  : delayPeriod: eq P5D -> {5}   gteq P1D -> [1,+inf)
%           : 5 >= 1 so an exact 5-day delay satisfies the at-least-1 bound. Compatible.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL810-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL810-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DUR000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(dur_d0, axiom, dur(d0)).
fof(dur_p1, axiom, dur(p1)).
fof(dur_p5, axiom, dur(p5)).
fof(ord_d0_p1, axiom, less(d0, p1)).
fof(ord_d0_p5, axiom, less(d0, p5)).
fof(ord_p1_p5, axiom, less(p1, p5)).
fof(distinct, axiom, $distinct(d0, p1, p5)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl810, conjecture,
    ?[X]: (in_closed(X, p5, p5) & leq(p1, X))).
%--------------------------------------------------------------------------
