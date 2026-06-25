%--------------------------------------------------------------------------
% File     : ODRL802-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : dateTime lt 2026-12-31 & gt 2026-12-31 -> Conflict
% Version  : 1.0
% English  : dateTime: lt 2026-12-31 -> (-inf,t)   gt 2026-12-31 -> (t,+inf)
%           : Strict bounds at the same instant: no X with X<t and t<X. Conflict.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL802-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL802-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl802, conjecture,
    ![X]: ~(less(X, d20261231) & less(d20261231, X))).
%--------------------------------------------------------------------------
