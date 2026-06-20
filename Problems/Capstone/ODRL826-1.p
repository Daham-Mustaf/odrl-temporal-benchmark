%--------------------------------------------------------------------------
% File     : ODRL826-1.p
% Domain   : ODRL Policy / Temporal Decomposition
% Problem  : BSB-BnF compatible variant -> Compatible
% Version  : 1.0
% English  : Same BSB offer, but BnF requests {dateTime eq 2026-05-31 (day 150),
%           : elapsedTime lteq P20D, timeInterval eq P30D @2026-01-01}. Day 150 is in
%           : BSB's window (<364) and on the shared P30D schedule (150 = 30*5), and the
%           : elapsed bounds agree. Values exist (dt=150, k=m=5). Compatible.
%
% Refs     : [Anonymous26d] Anonymous. Sort-Stratified Semantics for ODRL: Resolving Temporal-Sort Ambiguity in Policy Constraints. LPAR-26 (anonymized for review).
% Source   : anonymous
% Authors  : anonymous
% Names    : ODRL826-1.p
%
% Status   : Theorem
% Verdict  : Compatible
% Relation : conflict
% SPC      : TF0_THM
%
% Comments : Temporal decomposition tier. LPAR-26 (anonymized).
%           : Policy source: Policies/ODRL826-policy.ttl
%--------------------------------------------------------------------------

% ─── Named constants and ordering ─────────────────────────────────────
% ─── Conjecture ────────────────────────────────────────────────────
tff(odrl826, conjecture,
    ?[DT:$int,EL:$int,DL:$int,K:$int,M:$int]: ($greatereq(EL,0) & $greatereq(DL,0) & $less(DT,364) & $lesseq(EL,30) & $greatereq(DL,1) & DT = $product(30,K) & $greatereq(K,0) & DT = 150 & $lesseq(EL,20) & DT = $product(30,M) & $greatereq(M,0))).
%--------------------------------------------------------------------------
