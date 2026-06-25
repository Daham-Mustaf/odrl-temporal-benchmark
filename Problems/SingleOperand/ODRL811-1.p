%--------------------------------------------------------------------------
% File     : ODRL811-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : delayPeriod eq P5D & gt P5D -> Conflict
% Version  : 1.0
% English  : delayPeriod: eq P5D -> {5}   gt P5D -> (5,+inf)
%           : An exact 5-day delay cannot be strictly greater than 5. Conflict.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL811-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : conflict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
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
