session Typed_Set_Theory = "HOL-Number_Theory" +
  description
    \<open> Set theory with types on top. \<close>
  sessions
    "HOL-Eisbach"

  theories

  (* Types on top of Isabelle/Pure *)
	"Soft_Types/Soft_Types"
 
	(* Isabelle/Mizar Foundation, Type System, and foundational MML *)
	"Isabelle_Mizar/mizar_HOL"
	"Isabelle_Mizar/mizar"
	"Isabelle_Mizar/mizar_ty"
	"Isabelle_Mizar/mizar_defs"
	"Isabelle_Mizar/mizar_reserve"
	"MML/tarski_0"
	"Isabelle_Mizar/mizar_fraenkel"
	"Isabelle_Mizar/mizar_methods"
	"MML/tarski"
  (* Not currently working:
  "Isabelle_Mizar/mizar_import"
	"Isabelle_Mizar/mizar_string"
	"Isabelle_Mizar/mizar_struct"
  *)


  (* MML Material *)
  (* Volatile, so removing from build for now:
	"MML/xboole_0"
	"MML/xtuple_0"
	"MML/enumset_1"
	"MML/xfamily"
	"MML/zfmisc_1"
	"MML/subset_1"
	"MML/relat_1"
	"MML/relset_1"
	"MML/funct_1"
	"MML/partfun_1"
	"MML/funcop_1"
	"MML/funct_2"
	"MML/binop_1"
	"MML/ordinal1"
	"MML/nat_1"
	"MML/int_1"
	"MML/binop_2"
	"MML/struct_0"
	"MML/graph_1"
	"MML/cat_1"
	"MML/finseq_1"
	"MML/compos_0"
	"MML/compos_1"
	"MML/extpro_1"
	"MML/fraenkel"
	"MML/funct_6"
	"MML/group_1"
	"MML/group_1a"
	"MML/group_2"
	"MML/group_int"
	"MML/memstr_0"
	"MML/vectsp_1"
	"MML/vectsp_2"
	"MML/pre_topc"
	"MML/polyalg1"
	"MML/algstr_0"
	"MML/rlvect_1"
	"MML/setfam_1"
	"MML/z2"
	*)


  (* Some more material from soft type experiments in Isabelle/ZF.
     These should be adapted to Tarski-Grothendieck to be compatible with the Mizar foundation.
	*)
	"tests/test"
	"tests/Old_ZF_Experiments/ZF_Typing_Examples"

session Isabelle_Set = "HOL" +
  description
    \<open> Isabelle/Set. A typed version of Tarski-Grothendieck set theory embedded in HOL \<close>
  sessions
    "HOL-Eisbach"

  theories

  (* Types on top of Isabelle/Pure *)
	"Soft_Types/Soft_Types"

  (* Tarski-Grothendieck Set Theory on top of HOL. *)
	"Isabelle_Set/Set_Theory"
	"Isabelle_Set/Pair"
	"Isabelle_Set/Examples/Typing_Examples"
	"Isabelle_Set/ZF_Compatibility"
