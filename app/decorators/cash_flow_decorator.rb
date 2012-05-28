class CashFlowDecorator < ApplicationDecorator
  decorates :cash_flow

  FIELDS_CRORE = [
    'profits_before_tax'            ,
    'profits_after_tax'            ,
    'depreciation'     ,
    'final_lease'      ,
    'lease_eq_res'   ,
    'pl_in_forex'    ,
    'gain_forex'     ,
    'pl_on_sale_of_assets'   ,
    'pl_on_sale_of_investments'   ,
    'profit_adj_on_sale_of_undertaking'  ,
    'interest_income'     ,
    'interest_paid_net'   ,
    'interest_net'     ,
    'dividend_received_operating_activity'   ,
    'dividend_net'      ,
    'investments'       ,
    'misc_income'    ,
    'amortisation_of_exps_on_operating_activity'    ,
    'assets_written_off'     ,
    'misc_exp'       ,
    'payment_to_vrs'    ,
    'provisions_written_off_net'  ,
    'provisions_gratutity'     ,
    'provisions_dimun_in_value_of_investment'   ,
    'provisions_for_bad_debts_npa'     ,
    'trade_and_other_receivables'     ,
    'trade_bills_purchased'   ,
    'inventories_operating_activity'     ,
    'trade_payble'     ,
    'tax_provision'    ,
    'direct_taxes'    ,
    'advance_tax_paid'   ,
    'loans_and_advancesanc'    ,
    'transfer_from_reserve'    ,
    'others_from_operating_activity'   ,
    'prior_year_adjustments'   ,
    'provisions_written_back'   ,
    'prior_year_tax'   ,
    'balances_written_back'   ,
    'other_assets'     ,
    'other_liabilites'     ,
    'change_in_deposits'   ,
    'change_in_borrowing'      ,
    'discounts_expenses_on_loans'    ,
    'increase_or_decrease_in_advances'   ,
    'increase_or_decrease_in_investments'   ,
    'net_stock_on_hire'   ,
    'leased_assets_net_of_sale'   ,
    'excess_depreciation_written_back'   ,
    'extra_ordinary_items'   ,
    'net_cash_flow_operating_activity'  ,
    'purchase_of_fixed_assets'   ,
    'sale_of_fixed_assets'   ,
    'capital_wip'    ,
    'capital_subsidy_received'   ,
    'purchase_of_investments'      ,
    'sale_of_investment_inves_activity'   ,
    'aquisition_of_companies'    ,
    'sale_of_undertaking_extra_ordinary_item'  ,
    'interest_received'       ,
    'dividend_received_iinvestment_activity'   ,
    'investment_income'     ,
    'inter_corporate_deposits'   ,
    'investment_in_subsidiaries'    ,
    'loan_to_subsidiariesidiaries'   ,
    'investment_in_group_co'  ,
    'iss_sh_acq_co'  ,
    'canc_inv_cos'   ,
    'certificate_of_deposit_in_bank'   ,
    'movment_in_loans'    ,
    'others_from_investment_activity'    ,
    'movement_in_working_capital'     ,
    'amortisation_of_exps_on_investment_activity'    ,
    'taxes_paid'     ,
    'expenses_capitalised'    ,
    'extra_ord_items_investment_activity'  ,
    'purchase_of_fixed_assets_leased_out'   ,
    'net_increase_or_decrease_in_current_asset'  ,
    'net_increase_or_decrease_in_advances'    ,
    'net_increase_or_decrease_in_current_liabilities'  ,
    'net_cash_used_in_investment_activity'   ,
    'proceedings_from_issue_of_equity_capital'  ,
    'proceedings_from_issue__of_pref_capital'  ,
    'proceedings_from_issue_of_sh_capital_inclusive_share_premimum' ,
    'redemption_capital'     ,
    'proceedings_from_issue_of_debentures'   ,
    'proceedings_from_bank_borrowings'    ,
    'proceedings_from_long_term_borrowings'  ,
    'proceddings_from_short_term_borrowings'  ,
    'proceedings_from_deposits'     ,
    'repayment_of_borrowings'     ,
    'share_application'    ,
    'loan_from_corporate_body'   ,
    'dividend_paid'     ,
    'interest_paid'       ,
    'financial_charges'      ,
    'cash_credit_advances'   ,
    'cash_capital_investment'   ,
    'others_from_financial_activity'    ,
    'foreign_exchange_gain_or_loss_from_fin_activity'   ,
    'share_premium'     ,
    'misc_exp_written_off'  ,
    'sale_of_investments_fin_activity'     ,
    'reserves'       ,
    'current_liabilities'      ,
    'loan_disbursed'    ,
    'inventory_fin_activity'     ,
    'extra_ord_item_fin_activity'  ,
    'deferrred_exp_against_borrowing'   ,
    'share_application_refund'   ,
    'on_redem_of_debentures'   ,
    'of_other_long_term_borrowings'  ,
    'of_short_term_borrowings'  ,
    'of_finance_lease_liabilities'  ,
    'shelter_assisant_reserve'    ,
    'repayment_of_short_term_borrowings'  ,
    'repayment_of_long_term_borrowings'  ,
    'net_cash_used_in_fin_activity'  ,
    'foreign_exchange_gain_loss_net_in_fin_activity' ,
    'net_increase_or_decrease_in_cash'  ,
    'cash_start_year'  ,
    'cash_end_year'
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
