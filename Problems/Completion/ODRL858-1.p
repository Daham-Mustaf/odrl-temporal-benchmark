%--------------------------------------------------------------------------
% File     : ODRL858-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : completing another operand does not rescue a conflict (soundness)
% Version  : 1.0
% English  : Soundness (Thm. unknown-sound): ODRL850 had dateTime in conflict and elapsedTime silent (Unknown
%           : overall = Conflict). Completing elapsedTime compatibly leaves the dateTime conflict untouched:
%           : policy_verdict(conflict, compatible) = conflict. A definite Conflict is stable under completion.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL858-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : verdict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL858-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl858, conjecture,
    policy_verdict(conflict, compatible) = conflict).
%--------------------------------------------------------------------------
