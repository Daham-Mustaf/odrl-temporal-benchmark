%--------------------------------------------------------------------------
% File     : ODRL870-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : sort-stratified reading keeps them incomparable -> no Conflict (Compatible)
% Version  : 1.0
% English  : WITH sort stratification the instant and the duration are in separate ordered domains (no cross-sort
%           : order fact), so the offer's dateTime constraint and the request's elapsedTime constraint are each
%           : satisfiable on their own axis (witnessed by inst334 and dur30 respectively) and never interact. The
%           : correct verdict is no conflict. This is the same policy pair as ODRL869; only the sort discipline differs.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL870-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : sort-ablation
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL870-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
fof(distinct, axiom, $distinct(dur30, inst334)).
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl870, conjecture,
    leq(inst334, inst334) & leq(dur30, dur30)).
%--------------------------------------------------------------------------
