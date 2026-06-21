%--------------------------------------------------------------------------
% File     : ODRL861-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : one silent operand makes the and-fold Unknown
% Version  : 1.0
% English  : dateTime and elapsedTime are compatible; delayPeriod is constrained only by the offer (request silent) so it is unknown; with no conflict the and-fold is unknown.
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies., 2026.
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL861-1.p
%
% Status   : Theorem
% Verdict  : Unknown
% Relation : verdict
% SPC      : FOF_THM_RFN
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL861-policy.ttl
%--------------------------------------------------------------------------
include('Axioms/ORD000-0.ax').
include('Axioms/DENOT000-0.ax').

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
fof(odrl861, conjecture,
    policy_verdict(policy_verdict(compatible, compatible), unknown) = unknown).
%--------------------------------------------------------------------------
