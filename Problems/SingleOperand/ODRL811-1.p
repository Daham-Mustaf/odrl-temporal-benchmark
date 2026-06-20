%--------------------------------------------------------------------------
% File     : ODRL811-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : delayPeriod eq P5D & gt P5D -> Conflict
% Version  : 1.0
% English  : delayPeriod: eq P5D -> {5}   gt P5D -> (5,+inf)
%           : An exact 5-day delay cannot be strictly greater than 5. Conflict.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL811-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL811-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DUR000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(dur_d0, axiom, dur(d0)).
fof(dur_p5, axiom, dur(p5)).
fof(ord_d0_p5, axiom, less(d0, p5)).
fof(distinct, axiom, $distinct(d0, p5)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl811, conjecture,
    ![X]: ~(in_closed(X, p5, p5) & less(p5, X))).
%--------------------------------------------------------------------------
