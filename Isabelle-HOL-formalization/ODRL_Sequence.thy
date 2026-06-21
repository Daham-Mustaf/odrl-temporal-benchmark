(*  ODRL_Sequence.thy
    def:trace, def:andseq, lem:andseq-strict, prop:collapse (Sec. 4.3)
*)
theory ODRL_Sequence
  imports ODRL_Structures
begin

text \<open>def:trace. A trace is a list of states with strictly increasing timestamps;
      each state induces a context with now = its timestamp.\<close>

record state =
  ts :: inst

definition wf_trace :: "state list \<Rightarrow> bool" where
  "wf_trace \<tau> \<longleftrightarrow> sorted_wrt (\<lambda>a b. ts a < ts b) \<tau>"

text \<open>A constraint here is satisfied at a state given a trigger instant (the bound
      for trig). Only delayPeriod-style constraints read trig.\<close>

type_synonym sat = "inst \<Rightarrow> state \<Rightarrow> bool"   \<comment> \<open>trig \<Rightarrow> state \<Rightarrow> holds\<close>

text \<open>def:andseq. Holds on \<tau> iff there is a non-decreasing index tuple j1\<le>...\<le>jn with
      each C_k satisfied at state j_k under trigger = timestamp of the previous
      satisfaction (free for k=1).\<close>

fun sat_seq :: "sat list \<Rightarrow> inst \<Rightarrow> state list \<Rightarrow> nat list \<Rightarrow> bool" where
  "sat_seq [] _ _ [] = True"
| "sat_seq (C#Cs) trg \<tau> (j#js) =
     (j < length \<tau> \<and> C trg (\<tau>!j) \<and> sat_seq Cs (ts (\<tau>!j)) \<tau> js)"
| "sat_seq _ _ _ _ = False"

definition andSequence :: "sat list \<Rightarrow> inst \<Rightarrow> state list \<Rightarrow> bool" where
  "andSequence Cs trg0 \<tau> \<longleftrightarrow>
     (\<exists>js. length js = length Cs \<and> sorted js \<and> (\<forall>j\<in>set js. j < length \<tau>)
           \<and> sat_seq Cs trg0 \<tau> js)"

definition unresolvable :: "sat list \<Rightarrow> inst \<Rightarrow> state list \<Rightarrow> bool" where
  "unresolvable Cs trg0 \<tau> \<longleftrightarrow> \<not> andSequence Cs trg0 \<tau>"

text \<open>lem:andseq-strict. A step forcing a positive delay forces strict index
      separation. Modeled: if at step k the satisfaction implies ts(state) > trig,
      then the chosen index strictly exceeds the previous one.\<close>

definition forces_pos_delay :: "sat \<Rightarrow> bool" where
  "forces_pos_delay C \<longleftrightarrow> (\<forall>trg s. C trg s \<longrightarrow> trg < ts s)"

lemma andseq_strict:
  assumes "wf_trace \<tau>"
    and   "forces_pos_delay C"
    and   "C (ts (\<tau>!jprev)) (\<tau>!j)"
    and   "jprev < length \<tau>" "j < length \<tau>"
  shows   "jprev < j"
  \<comment> \<open>[routine] forces_pos_delay gives ts(\<tau>!jprev) < ts(\<tau>!j); strict-increasing
       timestamps (wf_trace) are injective and order-reflecting on indices.\<close>
  sorry  \<comment> \<open>TODO: strict-increasing timestamps order-reflect on indices\<close>

text \<open>prop:collapse. With no constraint reading trig, sequencing on a single-state
      trace coincides with conjunction at that state.\<close>

definition reads_trig :: "sat \<Rightarrow> bool" where
  "reads_trig C \<longleftrightarrow> (\<exists>t1 t2 s. C t1 s \<noteq> C t2 s)"

lemma collapse_to_and:
  assumes "\<forall>C\<in>set Cs. \<not> reads_trig C"
  shows   "andSequence Cs trg0 [s] \<longleftrightarrow> (\<forall>C\<in>set Cs. C trg0 s)"
  \<comment> \<open>[routine] on [s] the only non-decreasing tuple is the constant 0...0; with no
       trig dependence each C's value is fixed by the state, so the sequence holds
       iff every C holds at s.\<close>
  sorry

end
