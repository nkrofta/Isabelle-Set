\<^marker>\<open>creator "Kevin Kappelmann"\<close>
theory Functions_Restrict
  imports HOL.HOL
begin

consts fun_restrict :: "('a \<Rightarrow> 'b) \<Rightarrow> 'c \<Rightarrow> 'a \<Rightarrow> 'b"

overloading
  fun_restrict_pred \<equiv> "fun_restrict :: ('a \<Rightarrow> 'b) \<Rightarrow> ('a \<Rightarrow> bool) \<Rightarrow> 'a \<Rightarrow> 'b"
begin
  definition "fun_restrict_pred f P x \<equiv> if P x then f x else undefined"
end

bundle fun_restrict_syntax
begin
notation fun_restrict ("(_)\<restriction>(\<^bsub>_\<^esub>)" [1000])
end
bundle no_fun_restrict_syntax
begin
no_notation fun_restrict ("(_)\<restriction>(\<^bsub>_\<^esub>)" [1000])
end
unbundle fun_restrict_syntax

lemma fun_restrict_eq [simp]:
  assumes "P x"
  shows "f\<restriction>\<^bsub>P\<^esub> x = f x"
  using assms unfolding fun_restrict_pred_def by auto

lemma fun_restrict_eq_if_not [simp]:
  assumes "\<not>(P x)"
  shows "f\<restriction>\<^bsub>P\<^esub> x = undefined"
  using assms unfolding fun_restrict_pred_def by auto

end