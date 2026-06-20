"""
temporal_axiom_data.py  (Temporal Decomposition generator)
===========================================================
Content for the temporal axiom files (.ax / .smt2) and the admissible
temporal-constraint fragment. gen_temporal_axioms.py renders this.

Order convention follows the ODRL benchmark: less/2 is the strict primitive,
leq/2 is its reflexive closure. Each problem is single-sorted (all instants,
or all durations).

DENOT000 mirrors AxisDecomposition AXIS000-0.ax; PREC000 mirrors its PREC000-0.ax,
adapted to the temporal operators.
"""

# --- Temporal constraint fragment, restricted to the admissible set ---------
# (paper Def. "Admissible constraint": operand -> sort, operand -> operators)
SORTS = {
    "dateTime":     "instant",
    "delayPeriod":  "duration",
    "elapsedTime":  "duration",
    "meteredTime":  "duration",
    "timeInterval": "duration",   # periodic; admits only eq
}
ADMISSIBLE = {
    "dateTime":     ["eq", "lt", "lteq", "gt", "gteq"],
    "delayPeriod":  ["eq", "gt", "gteq"],
    "elapsedTime":  ["eq", "lt", "lteq"],
    "meteredTime":  ["eq", "lt", "lteq"],
    "timeInterval": ["eq"],
}

# --- Axiom bodies -----------------------------------------------------------
ORD000_FOF = """\
% ==========================================================================
% Core: Strict total order (3 axioms)
% ==========================================================================
% Irreflexivity: nothing is less than itself
fof(irreflexive, axiom, ![X]: ~less(X,X)).
% Transitivity: less-than chains
fof(transitive, axiom, ![X,Y,Z]:
    ((less(X,Y) & less(Y,Z)) => less(X,Z))).
% Trichotomy: for any two elements, exactly one of <, =, > holds
fof(trichotomy, axiom, ![X,Y]:
    (less(X,Y) | X = Y | less(Y,X))).
% ==========================================================================
% Derived: Non-strict order (1 axiom)
% ==========================================================================
% leq defined as the reflexive closure of less
fof(leq_def, axiom, ![X,Y]:
    (leq(X,Y) <=> (less(X,Y) | X = Y))).
% ==========================================================================
% Helper lemmas (derivable but aid Vampire/E performance)
% ==========================================================================
% Antisymmetry of leq
fof(leq_antisym, axiom, ![X,Y]:
    ((leq(X,Y) & leq(Y,X)) => X = Y)).
% less implies leq
fof(less_implies_leq, axiom, ![X,Y]:
    (less(X,Y) => leq(X,Y))).
% Mixed transitivity
fof(leq_less_trans, axiom, ![X,Y,Z]:
    ((leq(X,Y) & less(Y,Z)) => less(X,Z))).
fof(less_leq_trans, axiom, ![X,Y,Z]:
    ((less(X,Y) & leq(Y,Z)) => less(X,Z))).
fof(leq_trans, axiom, ![X,Y,Z]:
    ((leq(X,Y) & leq(Y,Z)) => leq(X,Z))).
"""

ORD001_FOF = """\
% ==========================================================================
% Density (1 axiom)
% ==========================================================================
% Density: between any two distinct values exists a third.
% Required for open-interval witnesses over continuous domains (R, Q).
% DO NOT include for discrete domains (integer counts).
%
% Example where density matters:
%   Policy 1: dateTime gt t1  -> denotation (t1, inf)
%   Policy 2: dateTime lt t2  -> denotation (-inf, t2)
%   Intersection (t1, t2) is non-empty only if dense.
%   Without density the prover cannot find a witness between t1 and t2.
fof(dense, axiom, ![X,Y]:
    (less(X,Y) => ?[Z]: (less(X,Z) & less(Z,Y)))).
"""

DUR000_FOF = """\
% ==========================================================================
% Duration sort and zero (2 axioms)
% ==========================================================================
% d0 is a duration: the zero-length duration
fof(zero_is_duration, axiom, dur(d0)).
% Non-negativity: every duration is at least the zero duration
fof(duration_non_negativity, axiom,
    ![X]: (dur(X) => leq(d0,X))).
"""

DENOT000_FOF = """\
% ==========================================================================
% Section A: Interval membership (Def. interval-denotation)
%   in_open(X,L,U)   <=> L < X < U      in_lopen(X,L,U)  <=> L < X <= U
%   in_ropen(X,L,U)  <=> L <= X < U     in_closed(X,L,U) <=> L <= X <= U
% A constraint denotes an interval; the operator fixes the form and bounds
% (eq v -> in_closed(X,v,v); lteq v -> in_lopen(X,floor,v); gteq v -> leq(v,X)).
% ==========================================================================
fof(in_open_def,   axiom, ![X,L,U]: (in_open(X,L,U)   <=> (less(L,X) & less(X,U)))).
fof(in_lopen_def,  axiom, ![X,L,U]: (in_lopen(X,L,U)  <=> (less(L,X) & leq(X,U)))).
fof(in_ropen_def,  axiom, ![X,L,U]: (in_ropen(X,L,U)  <=> (leq(L,X) & less(X,U)))).
fof(in_closed_def, axiom, ![X,L,U]: (in_closed(X,L,U) <=> (leq(L,X) & leq(X,U)))).
% ==========================================================================
% Section B: Three-valued verdict constants (Conflict < Unknown < Compatible)
% ==========================================================================
fof(verdicts_distinct, axiom, $distinct(compatible, conflict, unknown)).
fof(verdict_total, axiom,
    ![V]: (is_verdict(V) <=> (V = compatible | V = conflict | V = unknown))).
fof(is_verdict_compatible, axiom, is_verdict(compatible)).
fof(is_verdict_conflict,   axiom, is_verdict(conflict)).
fof(is_verdict_unknown,    axiom, is_verdict(unknown)).
% ==========================================================================
% Section C: policy_verdict -- Kleene min over per-operand verdicts
%   conflict if any operand conflicts; compatible iff all compatible;
%   unknown otherwise. Temporal analogue of the spatial box_verdict.
% ==========================================================================
fof(policy_conflict, axiom,
    ![V1,V2]: ((is_verdict(V1) & is_verdict(V2) & (V1 = conflict | V2 = conflict))
               => policy_verdict(V1,V2) = conflict)).
fof(policy_compatible, axiom,
    ![V1,V2]: ((is_verdict(V1) & is_verdict(V2) & V1 = compatible & V2 = compatible)
               => policy_verdict(V1,V2) = compatible)).
fof(policy_unknown, axiom,
    ![V1,V2]: ((is_verdict(V1) & is_verdict(V2) & (V1 = unknown | V2 = unknown)
                & V1 != conflict & V2 != conflict)
               => policy_verdict(V1,V2) = unknown)).
fof(policy_verdict_total, axiom,
    ![V1,V2]: ((is_verdict(V1) & is_verdict(V2))
               => (policy_verdict(V1,V2) = compatible
                 | policy_verdict(V1,V2) = conflict
                 | policy_verdict(V1,V2) = unknown))).
% ==========================================================================
% Section D: per-operand containment and disjointness (closed-closed)
%   interval_subsumes: [L1,U1] subseteq [L2,U2]
%   interval_conflict: [L1,U1] cap [L2,U2] = empty (strict, closed-closed)
%   Mixed open/closed endpoints use prec/4 from PREC000-0.ax instead.
% ==========================================================================
fof(interval_subsumes_def, axiom,
    ![L1,U1,L2,U2]: (interval_subsumes(L1,U1,L2,U2) <=> (leq(L2,L1) & leq(U1,U2)))).
fof(interval_conflict_def, axiom,
    ![L1,U1,L2,U2]: (interval_conflict(L1,U1,L2,U2) <=> (less(U1,L2) | less(U2,L1)))).
"""

PREC000_FOF = """\
% ==========================================================================
% Section 1: Tag sort {c, o}  (closed / open endpoint)
% ==========================================================================
fof(tag_c,         axiom, tag(c)).
fof(tag_o,         axiom, tag(o)).
fof(tags_distinct, axiom, c != o).
% ==========================================================================
% Section 2: Endpoint precedence (u prec l)
%   (c,c) both closed -> u prec l iff u < l   (strict; closed endpoints touch)
%   (o,c)/(c,o)/(o,o) some open -> u prec l iff u <= l
% ==========================================================================
fof(prec_cc, axiom, ![U,L]: (prec(U,L,c,c) <=> less(U,L))).
fof(prec_oc, axiom, ![U,L]: (prec(U,L,o,c) <=> leq(U,L))).
fof(prec_co, axiom, ![U,L]: (prec(U,L,c,o) <=> leq(U,L))).
fof(prec_oo, axiom, ![U,L]: (prec(U,L,o,o) <=> leq(U,L))).
% ==========================================================================
% Section 3: Disjointness criterion
%   disjoint iff the upper endpoint of one precedes the lower of the other.
% ==========================================================================
fof(disjoint_def, axiom,
    ![L1,U1,CL1,CU1,L2,U2,CL2,CU2]:
      (disjoint(L1,U1,CL1,CU1,L2,U2,CL2,CU2)
       <=> (prec(U1,L2,CU1,CL2) | prec(U2,L1,CU2,CL1)))).
% ==========================================================================
% Section 4: Operator-to-tag mapping (temporal operators)
%   eq -> upper c & lower c   lteq -> upper c   gteq -> lower c
%   lt -> upper o             gt   -> lower o
% ==========================================================================
fof(upper_tag_eq,   axiom, upper_tag(eq,   c)).
fof(upper_tag_lteq, axiom, upper_tag(lteq, c)).
fof(upper_tag_lt,   axiom, upper_tag(lt,   o)).
fof(lower_tag_eq,   axiom, lower_tag(eq,   c)).
fof(lower_tag_gteq, axiom, lower_tag(gteq, c)).
fof(lower_tag_gt,   axiom, lower_tag(gt,   o)).
fof(upper_tag_functional, axiom,
    ![OP,T1,T2]: ((upper_tag(OP,T1) & upper_tag(OP,T2)) => T1 = T2)).
fof(lower_tag_functional, axiom,
    ![OP,T1,T2]: ((lower_tag(OP,T1) & lower_tag(OP,T2)) => T1 = T2)).
"""

ORD000_SMT = """\
; Instants and durations are modelled as Real (dense, ordered).
; Strict less and its reflexive closure leq mirror the TPTP predicate names.
(define-fun less ((x Real) (y Real)) Bool (< x y))
(define-fun leq  ((x Real) (y Real)) Bool (<= x y))
"""

ORD001_SMT = """\
; Density is automatic in the Real model (no assertion needed).
; This file exists only to mirror the TPTP ORD001-0.ax include.
"""

DUR000_SMT = """\
; Zero duration and the non-negativity convention.
; Each duration variable d asserts (leq d0 d) in its problem.
(define-fun d0 () Real 0.0)
"""

DENOT000_SMT = """\
; Interval membership over Real (instants / durations); mirrors TPTP in_* names.
(define-fun in_open   ((x Real)(l Real)(u Real)) Bool (and (< l x) (< x u)))
(define-fun in_lopen  ((x Real)(l Real)(u Real)) Bool (and (< l x) (<= x u)))
(define-fun in_ropen  ((x Real)(l Real)(u Real)) Bool (and (<= l x) (< x u)))
(define-fun in_closed ((x Real)(l Real)(u Real)) Bool (and (<= l x) (<= x u)))
; Verdict is decided by the problem status: unsat = Conflict, sat = Compatible.
; The three-valued algebra (Unknown) is encoded per-problem where it arises.
"""

PREC000_SMT = """\
; No SMT counterpart: the arithmetic solver derives endpoint precedence and
; disjointness directly. This snippet mirrors the TPTP PREC000-0.ax include.
"""

PER000_FOF = """\
% ==========================================================================
% recurs/3 (Mod tier): periodic membership over the integer timeline.
%   recurs(T, A, P)  <=>  ?K>=0 . T = A + P*K
% A period-P schedule anchored at A is the set { A + P*K : K >= 0 }. Two
% periodic (timeInterval) constraints share an access instant iff their
% schedules coincide, i.e. gcd(P1,P2) | (A2 - A1). Problems instantiate A and
% P with integer literals, so every instance is linear (Presburger).
% ==========================================================================
tff(recurs_type, type, recurs : ( $int * $int * $int ) > $o ).
tff(recurs_def, axiom,
    ! [T: $int, A: $int, P: $int] :
      ( recurs(T, A, P)
    <=> ? [K: $int] : ( $greatereq(K, 0) & T = $sum(A, $product(P, K)) ) ) ).
"""

PER000_SMT = """\
; Mod tier: periodic recurrence over the integer timeline (QF_LIA).
; A period-P schedule anchored at A:  t = A + P*k, with k >= 0  (k : Int).
; Two schedules coincide iff  ?t,k,m >= 0 . A1 + P1*k = A2 + P2*m,
; equivalently gcd(P1,P2) | (A2 - A1). Problems inline this directly;
; sat = compatible, unsat = conflict.
"""

FRAME000_FOF = """\
% ==========================================================================
% Cross-operand background theory Phi (Diff / Mod tiers).
% An access carries integer-valued temporal quantities:
%   acc_dt : access instant (day on the timeline)   acc_el : elapsedTime
%   acc_me : meteredTime                             acc_dl : delayPeriod
% Phi: every duration is non-negative, and metered time never exceeds
% elapsed time. Cross-operand and capstone problems quantify over an access
% and read these accessors; the SMT side inlines Phi over Int constants.
% ==========================================================================
tff(access_type, type, access : $tType ).
tff(acc_dt_decl, type, acc_dt : access > $int ).
tff(acc_el_decl, type, acc_el : access > $int ).
tff(acc_me_decl, type, acc_me : access > $int ).
tff(acc_dl_decl, type, acc_dl : access > $int ).
tff(phi_nonneg, axiom,
    ! [A: access] :
      ( $greatereq(acc_el(A), 0) & $greatereq(acc_me(A), 0) & $greatereq(acc_dl(A), 0) ) ).
tff(phi_metered_le_elapsed, axiom,
    ! [A: access] : $lesseq(acc_me(A), acc_el(A)) ).
"""

FRAME000_SMT = """\
; Cross-operand background theory Phi (QF_LIA, inlined per problem):
;   elapsedTime, meteredTime, delayPeriod >= 0   (Int, day counts)
;   meteredTime <= elapsedTime
; Problems declare the relevant quantities as Int and assert Phi + the
; per-operand constraints; unsat = Conflict, sat = Compatible.
"""

SEQ000_FOF = """\
% ==========================================================================
% Diff tier: sequences as a Simple Temporal Network (STN).
% Each event carries an integer time stamp evt_time. An andSequence edge
% seq(E,F) orders the two events in time (evt_time(E) <= evt_time(F));
% duration gaps and deadlines become difference constraints
% evt_time(F) - evt_time(E) <op> d, i.e. QF_IDL. Two policies conflict iff
% the combined network is inconsistent (a negative cycle). Problems quantify
% over events; the SMT side inlines the differences over Int time points.
% ==========================================================================
tff(event_type, type, event : $tType ).
tff(evt_time_decl, type, evt_time : event > $int ).
tff(seq_decl, type, seq : ( event * event ) > $o ).
tff(seq_orders_time, axiom,
    ! [E: event, F: event] : ( seq(E, F) => $lesseq(evt_time(E), evt_time(F)) ) ).
"""

SEQ000_SMT = """\
; Diff tier: Simple Temporal Network (QF_IDL, inlined per problem).
; Event time points are Int; andSequence edges and duration gaps become
; difference constraints (- t_j t_i) <op> d. Problems declare the time
; points and assert the differences; unsat = Conflict (a negative cycle),
; sat = Compatible.
"""

AXIOMS = [
    {
        "code": "ORD000-0",
        "title": "Strict total order for temporal interval reasoning",
        "english": (
            "Foundation order for the temporal fragment. Defines a strict total\n"
            "order (less/2) and the derived non-strict order (leq/2). A problem is\n"
            "single-sorted: all instants, or all durations."
        ),
        "fof": ORD000_FOF,
        "fof_breakdown": ("irreflexive, transitive, trichotomy, leq_def, leq_antisym, "
                          "less_implies_leq, leq_less_trans, less_leq_trans, leq_trans"),
        "comments_note": (
            "Included explicitly by every problem file as the first include.\n"
            "No axiom file self-includes this file (flat include architecture)."
        ),
        "smt": ORD000_SMT,
        "smt_title": "Strict total order (Real model)",
        "smt_comment": "Order from the Real theory; less/leq macros mirror the TPTP names.",
    },
    {
        "code": "ORD001-0",
        "title": "Density of the strict order",
        "english": (
            "Density: between any two ordered points lies a third. Included only by\n"
            "problems with open (lt/gt) bounds on a continuous domain. Adds an\n"
            "existential, so such problems leave EPR."
        ),
        "fof": ORD001_FOF,
        "fof_breakdown": "dense",
        "comments_note": (
            "Depends on ORD000-0.ax (loaded by the problem file before this file).\n"
            "Omit for discrete domains (integer counts)."
        ),
        "smt": ORD001_SMT,
        "smt_title": "Density (Real model, vacuous)",
        "smt_comment": "Density is built into Real; this snippet mirrors the TPTP include only.",
    },
    {
        "code": "DUR000-0",
        "title": "Duration domain: sort, zero, and non-negativity",
        "english": (
            "The duration sort dur, its least element d0 (zero-length duration), and\n"
            "0 <= d for every duration. The monoid (+) lives in the typed arithmetic\n"
            "layer used by the Diff and Mod tiers."
        ),
        "fof": DUR000_FOF,
        "fof_breakdown": "zero_is_duration, duration_non_negativity",
        "comments_note": (
            "Included only by duration-operand problems; leaves the timeline order\n"
            "untouched (no constant forces a least instant)."
        ),
        "smt": DUR000_SMT,
        "smt_title": "Duration zero and non-negativity (Real model)",
        "smt_comment": "Durations are non-negative Reals; period indices use Int (Mod tier).",
    },
    {
        "code": "DENOT000-0",
        "title": "Interval denotation and verdict algebra",
        "english": (
            "Interval denotation (in_open/in_lopen/in_ropen/in_closed) and the three-valued\n"
            "verdict algebra (compatible/conflict/unknown) with the policy_verdict Kleene\n"
            "combinator and the closed-closed interval criteria. Mirrors AXIS000-0.ax."
        ),
        "fof": DENOT000_FOF,
        "fof_breakdown": ("4 interval membership + 5 verdict-constant + "
                          "4 policy_verdict + 2 interval criteria"),
        "comments_note": (
            "Denotation + verdict core; included by every problem after ORD000-0.ax.\n"
            "Uses verdict-value functions, so problems are not pure EPR."
        ),
        "smt": DENOT000_SMT,
        "smt_title": "Constraint denotation (realised directly in Real)",
        "smt_comment": "Operators map to Real relations inline; conflict = unsat, compatible = sat.",
    },
    {
        "code": "PREC000-0",
        "title": "Endpoint precedence, disjointness criterion, operator-tag mapping",
        "english": (
            "Endpoint precedence with open/closed tags (prec/4), the disjointness criterion\n"
            "(disjoint/8), and the operator-to-tag mapping for the temporal operators.\n"
            "Mirrors AXIS-side PREC000-0.ax; handles mixed open/closed intervals."
        ),
        "fof": PREC000_FOF,
        "fof_breakdown": ("3 tag-sort + 4 prec + 1 disjoint + "
                          "6 operator-tag + 2 functionality"),
        "comments_note": (
            "General conflict criterion for mixed open/closed intervals.\n"
            "Included by ConflictCriterion problems on top of DENOT000-0.ax."
        ),
        "smt": PREC000_SMT,
        "smt_title": "Conflict criterion (no SMT counterpart)",
        "smt_comment": "The arithmetic solver derives these directly; mirrors the TPTP include.",
    },
    {
        "code": "PER000-0",
        "title": "Periodic recurrence (Mod tier, gcd / divisibility)",
        "english": (
            "recurs(T,A,P): instant T lies on the period-P schedule anchored at A,\n"
            "i.e. T = A + P*K for some K >= 0. Two periodic (timeInterval) constraints\n"
            "share an access iff their schedules coincide: gcd(P1,P2) | (A2 - A1)."
        ),
        "fof": PER000_FOF,
        "fof_breakdown": "recurs_type, recurs_def (TFF, $int)",
        "comments_note": (
            "Mod tier: integer arithmetic. Problems instantiate A,P with literals\n"
            "(linear / Presburger). The SMT side is QF_LIA; resolution provers with no\n"
            "arithmetic cannot decide the no-coincidence (conflict) cases."
        ),
        "smt": PER000_SMT,
        "smt_title": "Periodic recurrence (QF_LIA)",
        "smt_comment": "Linear integer recurrence; sat = compatible, unsat = conflict.",
    },
    {
        "code": "FRAME000-0",
        "title": "Cross-operand background theory (Phi)",
        "english": (
            "An access carries integer temporal quantities (acc_dt instant, acc_el\n"
            "elapsedTime, acc_me meteredTime, acc_dl delayPeriod). Phi: durations are\n"
            "non-negative and meteredTime <= elapsedTime. Links operands that are\n"
            "otherwise independent; used by CrossOperand and the BSB-BnF capstone."
        ),
        "fof": FRAME000_FOF,
        "fof_breakdown": "access type + 4 accessors + phi_nonneg + phi_metered_le_elapsed (TFF, $int)",
        "comments_note": (
            "Documentation of the cross-operand frame. Both the TPTP and SMT problems\n"
            "inline Phi over $int (as PER000 does for the recurrence), so each instance\n"
            "is self-contained; this file is the canonical statement of Phi."
        ),
        "smt": FRAME000_SMT,
        "smt_title": "Cross-operand Phi (QF_LIA, inlined)",
        "smt_comment": "Durations >= 0 and metered <= elapsed; inlined per problem.",
    },
    {
        "code": "SEQ000-0",
        "title": "Sequence / Simple Temporal Network (Diff tier)",
        "english": (
            "Events carry integer time stamps (evt_time). An andSequence edge seq(E,F)\n"
            "orders them in time; duration gaps and deadlines are difference constraints\n"
            "(QF_IDL). Two policies conflict iff the combined network has a negative\n"
            "cycle. Used by the Sequence category."
        ),
        "fof": SEQ000_FOF,
        "fof_breakdown": "event type + evt_time accessor + seq relation + seq_orders_time (TFF, $int)",
        "comments_note": (
            "Documentation of the Diff-tier STN. Both the TPTP and SMT problems inline\n"
            "the difference constraints over $int, so each instance is self-contained;\n"
            "this file is the canonical statement of the sequence/STN semantics."
        ),
        "smt": SEQ000_SMT,
        "smt_title": "Sequence / STN (QF_IDL, inlined)",
        "smt_comment": "Difference constraints over Int time points; unsat = negative cycle.",
    },
]