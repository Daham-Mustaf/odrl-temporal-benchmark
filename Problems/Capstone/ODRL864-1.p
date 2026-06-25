%--------------------------------------------------------------------------
% File     : ODRL864-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : BSB-BnF structure with conflicts resolved -> Unknown
% Version  : 1.0
% English  : Same four-operand structure with the two conflicts removed: dateTime aligned (both eq 2026-06-01),
%           : timeInterval aligned (both eq P30D, shared anchor), elapsedTime overlap, delayPeriod still silent in
%           : the request. The vector is [compatible, compatible, unknown, compatible], so the and-fold is Unknown
%           : -- a single silent operand keeps the whole policy pair underdetermined.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL864-1.p
%
% Status   : Theorem
% Verdict  : Unknown
% Relation : verdict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL864-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl864, conjecture,
    policy_verdict(policy_verdict(policy_verdict(compatible, compatible), unknown), compatible) = unknown).
%--------------------------------------------------------------------------
