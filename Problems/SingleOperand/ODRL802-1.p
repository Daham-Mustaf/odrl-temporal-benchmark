%--------------------------------------------------------------------------
% File     : ODRL802-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : dateTime lt 2026-12-31 & gt 2026-12-31 -> Conflict
% Version  : 1.0
% English  : dateTime: lt 2026-12-31 -> (-inf,t)   gt 2026-12-31 -> (t,+inf)
%           : Strict bounds at the same instant: no X with X<t and t<X. Conflict.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL802-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL802-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl802, conjecture,
    ![X]: ~(less(X, d20261231) & less(d20261231, X))).
%--------------------------------------------------------------------------
