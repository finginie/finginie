class CashFlowDecorator < ApplicationDecorator
  decorates :cash_flow

  FIELDS_CRORE = [
    'pbt'            ,
    'pat'            ,
    'depreciatn'     ,
    'fin_lease'      ,
    'lease_eq_res'   ,
    'pl_in_forex'    ,
    'gain_forex'     ,
    'pl_sale_asst'   ,
    'pl_sale_invs'   ,
    'p_adj_s_undrt'  ,
    'intrst_inc'     ,
    'int_paid_net'   ,
    'intrst_net'     ,
    'dvdnd_rec_op'   ,
    'dvdnd_net'      ,
    'invstmts'       ,
    'misc_income'    ,
    'amrtsatn_op'    ,
    'asst_w_off'     ,
    'misc_exp'       ,
    'paymtto_vrs'    ,
    'prov_w_off_nt'  ,
    'prov_graty'     ,
    'prov_dim_inv'   ,
    'prov_bdnpa'     ,
    'trd_recvbl'     ,
    'trd_bill_pur'   ,
    'invnt_oprt'     ,
    'trd_payble'     ,
    'tax_provisn'    ,
    'dirct_taxes'    ,
    'adv_tax_paid'   ,
    'loan_advanc'    ,
    'trans_resrv'    ,
    'oth_oprt_act'   ,
    'pr_yr_adjust'   ,
    'prv_writ_bck'   ,
    'prior_yr_tax'   ,
    'bal_writ_bck'   ,
    'oth_assets'     ,
    'oth_liablt'     ,
    'ch_in_depsit'   ,
    'chin_borr'      ,
    'disc_exp_ln'    ,
    'inc_dec_advn'   ,
    'inc_dec_invs'   ,
    'net_stk_hire'   ,
    'l_ast_netsal'   ,
    'exces_dep_wb'   ,
    'extr_ord_itm'   ,
    'net_c_flow_op'  ,
    'pur_fix_asst'   ,
    'sal_fix_asst'   ,
    'capital_wip'    ,
    'cap_subs_rec'   ,
    'pur_invst'      ,
    'sal_invst_ia'   ,
    'aqustn_comp'    ,
    'sal_ut_ex_itm'  ,
    'int_recd'       ,
    'dvnd_recd_ia'   ,
    'invst_incm'     ,
    'intr_crp_dep'   ,
    'inv_in_subs'    ,
    'loan_to_subs'   ,
    'inv_in_grp_co'  ,
    'iss_sh_acq_co'  ,
    'canc_inv_cos'   ,
    'cert_dep_bnk'   ,
    'movmt_loans'    ,
    'oth_inv_act'    ,
    'movmt_wcap'     ,
    'amrt_exp_ia'    ,
    'taxes_paid'     ,
    'exp_captlsd'    ,
    'ex_ord_itm_ia'  ,
    'p_fix_ast_lo'   ,
    'nt_id_cur_ast'  ,
    'net_id_advn'    ,
    'nt_id_cur_lib'  ,
    'nt_csh_in_ia'   ,
    'pr_iss_eq_cap'  ,
    'pr_iss_pr_cap'  ,
    'pr_iss_sh_prem' ,
    'redmtn_cap'     ,
    'proc_iss_deb'   ,
    'pr_bnk_borr'    ,
    'pr_l_trm_borr'  ,
    'pr_sh_trm_bor'  ,
    'pr_deposit'     ,
    'repmt_borr'     ,
    'sh_applictn'    ,
    'ln_corp_body'   ,
    'dvdnd_paid'     ,
    'int_paid'       ,
    'fin_chrgs'      ,
    'csh_crdt_adv'   ,
    'csh_cap_invs'   ,
    'oth_fin_act'    ,
    'fe_gn_los_fa'   ,
    'sh_premium'     ,
    'mis_exp_w_off'  ,
    'sal_inv_fa'     ,
    'reserves'       ,
    'curr_liab'      ,
    'ln_disburse'    ,
    'invntry_fa'     ,
    'ex_ord_itm_fa'  ,
    'dfrd_exp_bor'   ,
    'sh_aplc_rfnd'   ,
    'on_redem_deb'   ,
    'of_oth_lt_bor'  ,
    'of_sh_trm_bor'  ,
    'of_fin_l_liab'  ,
    'shltr_a_res'    ,
    'rep_s_trm_bor'  ,
    'rep_l_trm_bor'  ,
    'nt_csh_usd_fa'  ,
    'fe_gn_ls_nt_fa' ,
    'n_inc_dec_csh'  ,
    'csh_strt_year'  ,
    'csh_end_year'
   ]

   FIELDS_CRORE.each do |item|
    define_method(item.to_sym) do
      model.send(item.to_sym) ? (model.send(item.to_sym) / 10000000).round : h.t('tables_not_available')
     end
   end

  def non_null_fields
    model.fields.keys.select { |key| !model.send(key.to_sym).nil? }
  end

end
