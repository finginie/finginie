class CashFlow
  include Mongoid::Document
  extend MongoidHelpers

  field  :company_code, :type => Float
  field  :year_ending, :type => Date
  field  :months, :type => Integer
  field  :type, :type => BigDecimal
  field  :pbt, :type => BigDecimal
  field  :pat, :type => BigDecimal
  field  :depreciatn, :type => BigDecimal
  field  :fin_lease, :type => BigDecimal
  field  :lease_eq_res, :type => BigDecimal
  field  :pl_in_forex, :type => BigDecimal
  field  :gain_forex, :type => BigDecimal
  field  :pl_sale_asst, :type => BigDecimal
  field  :pl_sale_invs, :type => BigDecimal
  field  :p_adj_s_undrt, :type => BigDecimal
  field  :intrst_inc, :type => BigDecimal
  field  :int_paid_net, :type => BigDecimal
  field  :intrst_net, :type => BigDecimal
  field  :dvdnd_rec_op, :type => BigDecimal
  field  :dvdnd_net, :type => BigDecimal
  field  :invstmts, :type => BigDecimal
  field  :misc_income, :type => BigDecimal
  field  :amrtsatn_op, :type => BigDecimal
  field  :asst_w_off, :type => BigDecimal
  field  :misc_exp, :type => BigDecimal
  field  :paymtto_vrs, :type => BigDecimal
  field  :prov_w_off_nt, :type => BigDecimal
  field  :prov_graty, :type => BigDecimal
  field  :prov_dim_inv, :type => BigDecimal
  field  :prov_bdnpa, :type => BigDecimal
  field  :trd_recvbl, :type => BigDecimal
  field  :trd_bill_pur, :type => BigDecimal
  field  :invnt_oprt, :type => BigDecimal
  field  :trd_payble, :type => BigDecimal
  field  :tax_provisn, :type => BigDecimal
  field  :dirct_taxes, :type => BigDecimal
  field  :adv_tax_paid, :type => BigDecimal
  field  :loan_advanc, :type => BigDecimal
  field  :trans_resrv, :type => BigDecimal
  field  :oth_oprt_act, :type => BigDecimal
  field  :pr_yr_adjust, :type => BigDecimal
  field  :prv_writ_bck, :type => BigDecimal
  field  :prior_yr_tax, :type => BigDecimal
  field  :bal_writ_bck, :type => BigDecimal
  field  :oth_assets, :type => BigDecimal
  field  :oth_liablt, :type => BigDecimal
  field  :ch_in_depsit, :type => BigDecimal
  field  :chin_borr, :type => BigDecimal
  field  :disc_exp_ln, :type => BigDecimal
  field  :inc_dec_advn, :type => BigDecimal
  field  :inc_dec_invs, :type => BigDecimal
  field  :net_stk_hire, :type => BigDecimal
  field  :l_ast_netsal, :type => BigDecimal
  field  :exces_dep_wb, :type => BigDecimal
  field  :prem_ls_land, :type => BigDecimal
  field  :extr_ord_itm, :type => BigDecimal
  field  :net_c_flow_op, :type => BigDecimal
  field  :pur_fix_asst, :type => BigDecimal
  field  :sal_fix_asst, :type => BigDecimal
  field  :capital_wip, :type => BigDecimal
  field  :cap_subs_rec, :type => BigDecimal
  field  :pur_invst, :type => BigDecimal
  field  :sal_invst_ia, :type => BigDecimal
  field  :aqustn_comp, :type => BigDecimal
  field  :sal_ut_ex_itm, :type => BigDecimal
  field  :int_recd, :type => BigDecimal
  field  :dvnd_recd_ia, :type => BigDecimal
  field  :invst_incm, :type => BigDecimal
  field  :intr_crp_dep, :type => BigDecimal
  field  :inv_in_subs, :type => BigDecimal
  field  :loan_to_subs, :type => BigDecimal
  field  :inv_in_grp_co, :type => BigDecimal
  field  :iss_sh_acq_co, :type => BigDecimal
  field  :canc_inv_cos, :type => BigDecimal
  field  :cert_dep_bnk, :type => BigDecimal
  field  :movmt_loans, :type => BigDecimal
  field  :oth_inv_act, :type => BigDecimal
  field  :movmt_wcap, :type => BigDecimal
  field  :amrt_exp_ia, :type => BigDecimal
  field  :taxes_paid, :type => BigDecimal
  field  :exp_captlsd, :type => BigDecimal
  field  :ex_ord_itm_ia, :type => BigDecimal
  field  :p_fix_ast_lo, :type => BigDecimal
  field  :nt_id_cur_ast, :type => BigDecimal
  field  :net_id_advn, :type => BigDecimal
  field  :nt_id_cur_lib, :type => BigDecimal
  field  :nt_csh_in_ia, :type => BigDecimal
  field  :pr_iss_eq_cap, :type => BigDecimal
  field  :pr_iss_pr_cap, :type => BigDecimal
  field  :pr_iss_sh_prem, :type => BigDecimal
  field  :redmtn_cap, :type => BigDecimal
  field  :proc_iss_deb, :type => BigDecimal
  field  :pr_bnk_borr, :type => BigDecimal
  field  :pr_l_trm_borr, :type => BigDecimal
  field  :pr_sh_trm_bor, :type => BigDecimal
  field  :pr_deposit, :type => BigDecimal
  field  :repmt_borr, :type => BigDecimal
  field  :sh_applictn, :type => BigDecimal
  field  :ln_corp_body, :type => BigDecimal
  field  :dvdnd_paid, :type => BigDecimal
  field  :int_paid, :type => BigDecimal
  field  :fin_chrgs, :type => BigDecimal
  field  :csh_crdt_adv, :type => BigDecimal
  field  :csh_cap_invs, :type => BigDecimal
  field  :oth_fin_act, :type => BigDecimal
  field  :fe_gn_los_fa, :type => BigDecimal
  field  :sh_premium, :type => BigDecimal
  field  :mis_exp_w_off, :type => BigDecimal
  field  :sal_inv_fa, :type => BigDecimal
  field  :reserves, :type => BigDecimal
  field  :curr_liab, :type => BigDecimal
  field  :ln_disburse, :type => BigDecimal
  field  :invntry_fa, :type => BigDecimal
  field  :ex_ord_itm_fa, :type => BigDecimal
  field  :dfrd_exp_bor, :type => BigDecimal
  field  :sh_aplc_rfnd, :type => BigDecimal
  field  :on_redem_deb, :type => BigDecimal
  field  :of_oth_lt_bor, :type => BigDecimal
  field  :of_sh_trm_bor, :type => BigDecimal
  field  :of_fin_l_liab, :type => BigDecimal
  field  :shltr_a_res, :type => BigDecimal
  field  :rep_s_trm_bor, :type => BigDecimal
  field  :rep_l_trm_bor, :type => BigDecimal
  field  :nt_csh_usd_fa, :type => BigDecimal
  field  :fe_gn_ls_nt_fa, :type => BigDecimal
  field  :n_inc_dec_csh, :type => BigDecimal
  field  :csh_strt_year, :type => BigDecimal
  field  :csh_end_year, :type => BigDecimal
  field  :modified_date, :type => DateTime

  key :company_code, :year_ending
end
