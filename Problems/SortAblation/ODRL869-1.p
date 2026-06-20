%--------------------------------------------------------------------------
% File     : ODRL869-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : naive unsorted reading collapses instant and duration -> spurious Conflict
% Version  : 1.0
% English  : WITHOUT sort stratification the instant 2026-12-01 (day 334) and the duration P30D (30) are placed on
%           : one axis via less(dur30, inst334); the offer's dateTime gteq day334 and the request's elapsedTime lteq
%           : 30 then require a single point with 334 <= X <= 30, which is impossible. The naive engine reports a
%           : Conflict that is not real: the operands never shared a domain to begin with.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL869-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : sort-ablation
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL869-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(cross_sort, axiom, less(dur30, inst334)).
fof(distinct, axiom, $distinct(dur30, inst334)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl869, conjecture,
    ![X] : ~( leq(inst334, X) & leq(X, dur30) )).
%--------------------------------------------------------------------------
