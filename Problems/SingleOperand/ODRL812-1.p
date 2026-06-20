%--------------------------------------------------------------------------
% File     : ODRL812-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : meteredTime lteq P10D & lteq P30D -> Compatible
% Version  : 1.0
% English  : meteredTime: lteq P10D -> [0,10]   lteq P30D -> [0,30]
%           : [0,10] is non-empty (witness 0). Compatible.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL812-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL812-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DUR000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(dur_d0, axiom, dur(d0)).
fof(dur_p10, axiom, dur(p10)).
fof(dur_p30, axiom, dur(p30)).
fof(ord_d0_p10, axiom, less(d0, p10)).
fof(ord_d0_p30, axiom, less(d0, p30)).
fof(ord_p10_p30, axiom, less(p10, p30)).
fof(distinct, axiom, $distinct(d0, p10, p30)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl812, conjecture,
    ?[X]: (in_closed(X, d0, p10) & in_closed(X, d0, p30))).
%--------------------------------------------------------------------------
