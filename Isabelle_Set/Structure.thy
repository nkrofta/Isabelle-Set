(* Title:  structure.thy
   Author: Joshua Chen, Alexander Krauss
   Date:   Jul 2019

Mathematical structures as set-theoretic functions.

*)

section \<open>Structures\<close>

theory Structure
imports Ordinal Function
keywords "struct" :: thy_decl

begin


subsection \<open>Labels for structure fields\<close>

ML \<open>
structure Labels: sig
  val string_to_hash : string -> term
end = struct

  (* TODO: binary encoding; proper symbol coverage *)
  fun hash i = funpow i (fn t => @{const "Succ"} $ t) @{term "{}"}
  val get_hash = Symtab.make [
    ("0", hash 0),
    ("1", hash 1),
    ("2", hash 2),
    ("3", hash 3),
    ("4", hash 4),
    ("5", hash 5),
    ("6", hash 6),
    ("7", hash 7),
    ("8", hash 8),
    ("9", hash 9),
    ("a", hash 10),
    ("b", hash 11),
    ("c", hash 12),
    ("d", hash 13),
    ("e", hash 14),
    ("f", hash 15),
    ("g", hash 16),
    ("h", hash 17),
    ("i", hash 18),
    ("j", hash 19),
    ("k", hash 20),
    ("l", hash 21),
    ("m", hash 22),
    ("n", hash 23),
    ("o", hash 24),
    ("p", hash 25),
    ("q", hash 26),
    ("r", hash 27),
    ("s", hash 28),
    ("t", hash 29),
    ("u", hash 30),
    ("v", hash 31),
    ("w", hash 32),
    ("x", hash 33),
    ("y", hash 34),
    ("z", hash 35)]
  |> Symtab.lookup


(* Convert strings to ordered tuples of the hashes of each letter. *)
fun string_to_hash str =
  let
    fun mk_pair (t1, t2) = @{const "Pair"} $ t1 $ t2
  in
    String.explode str |>  map (the o get_hash o Char.toString) |> foldr1 mk_pair
  end

end
\<close>


subsection \<open>Structure type declarations\<close>

definition selector :: "[set, set] \<Rightarrow> set" ("(_)[(_)]" [901, 0] 900)
  where "struct[lbl] \<equiv> struct ` lbl"

definition comp :: "set \<Rightarrow> (set \<Rightarrow> set \<Rightarrow> bool) \<Rightarrow> set \<Rightarrow> bool"
  where "comp lbl pred \<equiv> (\<lambda>x. pred (x[lbl]) x)"

definition "K x = (\<lambda>_. x)"

nonterminal struct_arg and struct_args

syntax
  "_struct_arg"    :: "set \<Rightarrow> id \<Rightarrow> struct_arg" ("'(_ _')")
  "_struct_args"   :: "struct_args \<Rightarrow> struct_arg \<Rightarrow> struct_args" ("_ _" [40, 41] 40)
  "_struct_comp"  :: "struct_args \<Rightarrow> logic \<Rightarrow> set type" ("\<lparr> _. _ \<rparr>")
  "_struct_comp2" :: "struct_args \<Rightarrow> logic \<Rightarrow> set type" 
  ""               :: "struct_arg \<Rightarrow> struct_args" ("_")

translations
  "_struct_comp args P" \<rightleftharpoons> "_struct_comp2 args (CONST K P)"
  "_struct_comp2 (_struct_args args (_struct_arg A a)) P" \<rightleftharpoons>
    "_struct_comp2 args (CONST comp A (\<lambda>a. P))"
  "_struct_comp2 (_struct_arg A a) P" \<rightleftharpoons> "CONST Type (CONST comp A (\<lambda>a. P))"


lemmas [type_iff] = comp_def K_def

lemma structure_simps [simp]:
  "M : Type (comp A P) \<longleftrightarrow> M : Type (P (M[A]))"
  "M : Type (K Q) \<longleftrightarrow> Q"
  by squash_types

lemma selector_simps [simp]:
  "(Cons x A)[lbl] \<equiv> (Cons x A)`lbl"
  by (fact selector_def)


text \<open>Structure declaration keyword:\<close>

ML \<open>
Outer_Syntax.local_theory @{command_keyword struct} "Declare structure definitions"
  let
    val parser = Parse.text -- (Parse.$$$ "=" |-- Parse.term)

    fun struct_cmd (name: string, struct_def_str) lthy =
      let
        (* Get the field labels used in the structure declaration.
           Relies on the specific form of the translations defined above! *)
        fun get_labels (@{const comp} $ A $ Abs (_, _, t)) = A :: get_labels t
          | get_labels (Const (@{const_name Type}, _) $ t) = get_labels t
          | get_labels (Const (@{const_name Int_type}, _) $ _ $ t) = get_labels t
          | get_labels _ = []

        val struct_def = Syntax.read_term lthy struct_def_str
        val labels = get_labels struct_def
        val new_lbls = filter is_Free labels

        (* Check for duplicate labels *)
        val _ =
          if has_duplicates (op =) labels
          then error "Structure type declaration has duplicate labels"
          else ()

        (* Define hashes for new labels *)
        fun define_label lbl = snd o (
          Local_Theory.define (
            (Binding.qualified_name lbl, NoSyn),
            ((Binding.qualified_name (lbl ^ "_lbldef"), []), Labels.string_to_hash lbl)
          ))

        (* Print information *)
        fun print_info name def =
          Output.information ("Structure declaration \"" ^ name ^ "\":\n " ^ def)

        (* Define structure type *)
        fun define_struct_type lthy =
          let val ((Free(name, _), (_, def)), lthy') =
            Local_Theory.define (
              (Binding.qualified_name name, NoSyn),
              ((Binding.qualified_name (name ^ "_typedef"), []),
                Syntax.read_term lthy struct_def_str)
            ) lthy
          in
            print_info name (Syntax.string_of_term lthy' (Thm.prop_of def));
            lthy'
          end

        (* Placeholder: generate typing judgments for the structure fields *)
        fun gen_typings _ = ()

        (* Placeholder: generate definitional axioms as theorems *)
        fun gen_conditions _ = ()
      in
        lthy
        |> fold (define_label o fst o dest_Free) new_lbls
        |> define_struct_type
        (* |> gen_typings |> gen_conditions *)
      end
  in
    (parser >> (fn (name, def) => fn lthy => struct_cmd (name, def) lthy))
  end
\<close>


text \<open>Structure instance definitions, essentially just syntactic sugar:\<close>

nonterminal instance_arg and instance_args

syntax
  "_instance_arg"  :: "[set, set] \<Rightarrow> instance_arg" (infix "=" 45)
  "_instance_args" :: "instance_arg \<Rightarrow> instance_args \<Rightarrow> instance_args" ("(1_ ,/ _)" [41, 40] 40)
  "_instance"      :: "instance_args \<Rightarrow> set" ("\<lparr> _ \<rparr>")
  ""               :: "instance_arg \<Rightarrow> instance_args" ("_")
  ""               :: "pttrn \<Rightarrow> instance_args" ("_")

translations
  "\<lparr> lbl = val \<rparr>" \<rightharpoonup> "{\<langle>lbl, val\<rangle>}"
  "\<lparr> lbl = val, fields \<rparr>" \<rightharpoonup> "CONST Cons \<langle>lbl, val\<rangle> \<lparr> fields \<rparr>"


end
