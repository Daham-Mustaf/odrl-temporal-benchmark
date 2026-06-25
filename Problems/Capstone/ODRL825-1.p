%--------------------------------------------------------------------------
% File     : ODRL825-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : BSB-BnF running example -> Conflict
% Version  : 1.0
% English  : BSB {dateTime lt 2026-12-31, elapsedTime lteq P30D, delayPeriod gteq P1D,
%           : timeInterval eq P30D @2026-01-01} vs BnF {dateTime eq 2027-06-01 (day 516),
%           : elapsedTime lteq P10D, timeInterval eq P45D @day 516}. No values satisfy
%           : both: the dateTime layer needs dt<364 and dt=516, and independently the
%           : periodic layer needs 15 | 516. Conflict (Vampire closes it via dt<364 & dt=516).
%
% Refs     : [MCK+26] D. M. Mustafa, D. Collarana, S. Kirrane, C. Lange, C. Quix, S. Geisler, S. Decker, R. Haque. Sort-Stratified Semantics for Temporal Conflict Detection in ODRL Policies. arXiv:2606.23442, 2026.
% Source   : https://github.com/Daham-Mustaf/odrl-temporal-benchmark
% Authors  : Mustafa, D.
% Names    : ODRL825-1.p
%
% Status   : Theorem
% Verdict  : Conflict
% Relation : conflict
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier.
%           : Policy source: Policies/ODRL825-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl825, conjecture,
    ![DT:$int,EL:$int,DL:$int,K:$int,M:$int]: ~($greatereq(EL,0) & $greatereq(DL,0) & $less(DT,364) & $lesseq(EL,30) & $greatereq(DL,1) & DT = $product(30,K) & $greatereq(K,0) & DT = 516 & $lesseq(EL,10) & DT = $sum(516,$product(45,M)) & $greatereq(M,0))).
%--------------------------------------------------------------------------
