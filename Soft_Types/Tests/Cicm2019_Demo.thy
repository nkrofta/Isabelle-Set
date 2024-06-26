(*
Demonstration of type elaboration so far.
Joshua Chen, Alexander Krauss

Presented at CICM '19, Prague.
*)
theory Cicm2019_Demo
imports Soft_Types.Soft_Types_HOL
begin

typedecl i
type_synonym U = "i type"
abbreviation "U \<equiv> Any :: U type" \<comment>\<open>reflection of the rigid type into the soft type system\<close>

text \<open>Polymorphic lists:\<close>

axiomatization list :: "U \<Rightarrow> U"
  and cons
  and nil
  and append
  \<comment>\<open>Declare the (soft!) types of constructors:\<close>
  where 1 [type implicit: 1]: "nil \<Ztypecolon> (A : U) \<Rightarrow> list A"
  and 2 [type implicit: 1]: "cons \<Ztypecolon> (A : U) \<Rightarrow> A \<Rightarrow> list A \<Rightarrow> list A"
  and 3 [type implicit: 1]: "append \<Ztypecolon> (A : U) \<Rightarrow> list A \<Rightarrow> list A \<Rightarrow> list A"


declare [[auto_elaborate]]

term "cons x xs"
term "append xs ys"
term "nil"

lemma "append xs nil = xs"
  oops

declare [[auto_elaborate=false]]


text \<open>An example from dependent type theory that we can't yet handle!\<close>

axiomatization Id
  and refl
  and J
  where Id_type [type implicit: 1]: "Id \<Ztypecolon> (A : U) \<Rightarrow> A \<Rightarrow> A \<Rightarrow> U"
  and refl_type [type implicit: 1]: "refl \<Ztypecolon> (A : U) \<Rightarrow> (x: A) \<Rightarrow> Id A x x"
  and J_type [type implicit: 2]: "J \<Ztypecolon> (A : U) \<Rightarrow>
    (C : (x : A) \<Rightarrow> (y: A) \<Rightarrow> (p: Id A x y) \<Rightarrow> U) \<Rightarrow>
    ((x: A) \<Rightarrow> C x x (refl A x)) \<Rightarrow> (a: A) \<Rightarrow> (b: A) \<Rightarrow> (p: Id A a b) \<Rightarrow> C a b p"


text \<open>The proof term for reflexivity of equality:\<close>

declare [[auto_elaborate]]
term J

(* term "J (\<lambda>x. refl x) a b p" *)


end
