%--------------------------------------------------------------------------
% File     : ODRL871-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : timeInterval eq P30D both (anchor day 0); dateTime windows [Jan1,Jan6] & [Jan4,Feb4] -> Conflict
% Version  : 1.0
% English  : Windowed recurrence conflict. Both policies recur every P30D from 2026-01-01, so their
%           : schedules coincide in Z (the gcd test alone reports Compatible). The dateTime windows are
%           : [2026-01-01,2026-01-06] (offer) and [2026-01-04,2026-02-04] (request); their overlap
%           : [2026-01-04,2026-01-06] contains no occurrence (occurrences fall on 2026-01-01,
%           : 2026-01-31, ...). A shared occurrence exists but none lies in the joint window, the case
%           : lem:windowed-rec handles. Each policy alone is realizable (offer 2026-01-01, request 2026-01-31).
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL871-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : conflict
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL871-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl871, conjecture,
    ![T:$int,K:$int,M:$int]: ~($greatereq(K,0) & $greatereq(M,0) & T = $sum(0, $product(30, K)) & T = $sum(0, $product(30, M)) & $greatereq(T,0) & $lesseq(T,5) & $greatereq(T,3) & $lesseq(T,34))).
%--------------------------------------------------------------------------
