%--------------------------------------------------------------------------
% File     : ODRL863-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : BSB-BnF running example, four-operand verdict vector -> Conflict
% Version  : 1.0
% English  : The paper's BSB-BnF table as a verdict vector over [dateTime, elapsedTime, delayPeriod, timeInterval]
%           : = [conflict, compatible, unknown, conflict]: dateTime disjoint (2027-06-01 not < 2026-12-31),
%           : elapsedTime overlap [0,P10D], delayPeriod silent in the request (unknown), timeInterval disjoint cycles
%           : (gcd(30,45)=15 does not divide the 516-day offset). The and-fold over the four is Conflict.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL863-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : verdict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL863-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl863, conjecture,
    policy_verdict(policy_verdict(policy_verdict(conflict, compatible), unknown), conflict) = conflict).
%--------------------------------------------------------------------------
