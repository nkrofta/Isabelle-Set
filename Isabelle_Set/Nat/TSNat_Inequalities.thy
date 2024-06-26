\<^marker>\<open>creator "Kevin Kappelmann"\<close>
subsubsection \<open>More inequalities\<close>
theory TSNat_Inequalities
  imports
    TSNat_Add
    TSNat_Sub
begin

lemma Nat_lt_sub_if_add_lt:
  assumes "l \<Ztypecolon> Nat" "m \<Ztypecolon> Nat" "n \<Ztypecolon> Nat"
  and "l + m < n"
  shows "l < n - m"
  using Nat_sub_lt_sub_if_le_if_lt[of n "l + m" m] assms Nat_le_add[of m l]
    by (auto simp: Nat_add_sub_assoc Nat_add_AC_rules)

lemma Nat_add_lt_if_lt_sub:
  assumes "m \<Ztypecolon> Nat" "n \<Ztypecolon> Nat"
  and "l < n - m"
  shows "l + m < n"
proof -
  from assms have "l \<Ztypecolon> Nat" by (auto intro: Nat_if_lt_Nat[of "n - m" l])
  then show ?thesis by (intro Nat_lt_if_sub_lt_sub[of "l + m" "n" m])
      (auto simp: Nat_add_sub_assoc)
qed

corollary Nat_lt_sub_iff_add_lt:
  assumes "l \<Ztypecolon> Nat" "m \<Ztypecolon> Nat" "n \<Ztypecolon> Nat"
  shows "l < n - m \<longleftrightarrow> l + m < n"
  by (auto intro: Nat_add_lt_if_lt_sub Nat_lt_sub_if_add_lt)


end