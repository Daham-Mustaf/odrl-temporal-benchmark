%--------------------------------------------------------------------------
% File     : ODRL813-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : meteredTime eq P30D & lteq P10D -> Conflict
% Version  : 1.0
% English  : meteredTime: eq P30D -> {30}   lteq P10D -> [0,10]
%           : 30 > 10 so {30} is outside [0,10]. Conflict.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL813-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL813-policy.ttl
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
fof(odrl813, conjecture,
    ![X]: ~(in_closed(X, p30, p30) & in_closed(X, d0, p10))).
%--------------------------------------------------------------------------
