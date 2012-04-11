class AuditedResult
  include Mongoid::Document
  extend MongoidHelpers

    field  :companycode,  :type => Float
    field  :year_ending,  :type => Date
    field  :months,  :type => Integer
    field  :type
    field  :face_value,  :type => Integer
    field  :operating_income,  :type => BigDecimal
    field  :manufacturingexpenses,  :type => BigDecimal
    field  :material_consumed,  :type => BigDecimal
    field  :personnel_exp,  :type => BigDecimal
    field  :selling_expenses,  :type => BigDecimal
    field  :admin_expenses,  :type => BigDecimal
    field  :exp_capitalised,  :type => BigDecimal
    field  :cost_of_sales,  :type => BigDecimal
    field  :banks_provisions_made,  :type => BigDecimal
    field  :operating_profit,  :type => BigDecimal
    field  :other_recurring_income,  :type => BigDecimal
    field  :adjusted_pbdit,  :type => BigDecimal
    field  :financial_expences,  :type => BigDecimal
    field  :depreciation,  :type => BigDecimal
    field  :prel_def_rev_exp_w_off,  :type => BigDecimal
    field  :adjusted_pbt,  :type => BigDecimal
    field  :taxation,  :type => BigDecimal
    field  :adjusted_pat,  :type => BigDecimal
    field  :non_recurring_income,  :type => BigDecimal
    field  :non_cash_adjustments,  :type => BigDecimal
    field  :reported_net_profit,  :type => BigDecimal
    field  :equity_dividend,  :type => BigDecimal
    field  :proposed_pref_divdnd,  :type => BigDecimal
    field  :retained_earnings,  :type => BigDecimal
    field  :appropriations,  :type => BigDecimal
    field  :sales_manufacturing,  :type => BigDecimal
    field  :sales_trading,  :type => BigDecimal
    field  :excise,  :type => BigDecimal
    field  :fundbased_income,  :type => BigDecimal
    field  :feebased_income,  :type => BigDecimal
    field  :fiscal_benefits,  :type => BigDecimal
    field  :raw_mat_consumed,  :type => BigDecimal
    field  :packing_material_consumed,  :type => BigDecimal
    field  :spares_stores_consmption,  :type => BigDecimal
    field  :purchase_finish_goods,  :type => BigDecimal
    field  :dec_inc_in_stocks,  :type => BigDecimal
    field  :power_fuel,  :type => BigDecimal
    field  :other_manufacturing_exp,  :type => BigDecimal
    field  :exp_advertising,  :type => BigDecimal
    field  :exp_other_promotion,  :type => BigDecimal
    field  :distribution_exp,  :type => BigDecimal
    field  :other_selling_expenses,  :type => BigDecimal
    field  :pl_sale_of_asset,  :type => BigDecimal
    field  :pl_onsaleof_invstmts,  :type => BigDecimal
    field  :insuranceclaims,  :type => BigDecimal
    field  :exchg_rate_fluct,  :type => BigDecimal
    field  :layoffretrench_vrs,  :type => BigDecimal
    field  :extr_ordinary_items,  :type => BigDecimal
    field  :contingent_liabilities,  :type => BigDecimal
    field  :export_fob_value,  :type => BigDecimal
    field  :export_earnings,  :type => BigDecimal
    field  :cif_value_imports,  :type => BigDecimal
    field  :imp_capital_goods,  :type => BigDecimal
    field  :foreign_exchange_expn,  :type => BigDecimal
    field  :imported_rawmat,  :type => BigDecimal
    field  :indigenious_rawmat,  :type => BigDecimal
    field  :imported_spares,  :type => BigDecimal
    field  :indigenious_spares,  :type => BigDecimal
    field  :equity_capital,  :type => BigDecimal
    field  :pref_capital,  :type => BigDecimal
    field  :share_appl_money,  :type => BigDecimal
    field  :authorised_capital,  :type => BigDecimal
    field  :resand_surplus,  :type => BigDecimal
    field  :free_reservesand_surplus,  :type => BigDecimal
    field  :other_reserves,  :type => BigDecimal
    field  :secured_loans,  :type => BigDecimal
    field  :unsecured_loans,  :type => BigDecimal
    field  :long_term_loan,  :type => BigDecimal
    field  :unsecured_term_loans,  :type => BigDecimal
    field  :borrowings_by_bank,  :type => BigDecimal
    field  :gross_block,  :type => BigDecimal
    field  :revaluation_reserve,  :type => BigDecimal
    field  :depreciation_on_f_assets,  :type => BigDecimal
    field  :net_block,  :type => BigDecimal
    field  :capital_wip,  :type => BigDecimal
    field  :investments,  :type => BigDecimal
    field  :current_assets,  :type => BigDecimal
    field  :curr_liab_and_prov,  :type => BigDecimal
    field  :net_current_assets,  :type => BigDecimal
    field  :cash_credits,  :type => BigDecimal
    field  :bills_purchased,  :type => BigDecimal
    field  :term_loans,  :type => BigDecimal
    field  :advances_outside_india,  :type => BigDecimal
    field  :adv_out_housing_loans,  :type => BigDecimal
    field  :inter_office_adj_net_liab,  :type => BigDecimal
    field  :misc_exp_not_w_off,  :type => BigDecimal
    field  :bonus_in_equity_cap,  :type => BigDecimal
    field  :numberof_equity_shares,  :type => BigDecimal
    field  :demand_deposits,  :type => BigDecimal
    field  :savings_deposits_un_secured,  :type => BigDecimal
    field  :time_deposits_un_secured,  :type => BigDecimal
    field  :dep_of_ind_branches,  :type => BigDecimal
    field  :dep_of_forgn_branches,  :type => BigDecimal
    field  :inv_india,  :type => BigDecimal
    field  :book_value,  :type => BigDecimal
    field  :market_value,  :type => BigDecimal
    field  :cash_and_bank_balance,  :type => BigDecimal
    field  :money_at_call_short_notice,  :type => BigDecimal
    field  :receivables,  :type => BigDecimal
    field  :loan_adv,  :type => BigDecimal
    field  :raw_inventory,  :type => BigDecimal
    field  :wip_inventory,  :type => BigDecimal
    field  :finished_goods_inventory,  :type => BigDecimal
    field  :other_inventory,  :type => BigDecimal
    field  :sundry_creditors,  :type => BigDecimal
    field  :other_current_liabilities,  :type => BigDecimal
    field  :total_provisions,  :type => BigDecimal
    field  :current_year_adj,  :type => BigDecimal
    field  :prev_year_adj,  :type => BigDecimal
    field  :adj_fix_ass,  :type => BigDecimal
    field  :purchases,  :type => BigDecimal
    field  :number_of_employees,  :type => Integer
    field  :number_of_branches,  :type => Integer
    field  :corporate_dividend_tax,  :type => BigDecimal
    field  :modified_date,  :type => DateTime

    key :companycode, :year_ending

    [
      :equity_capital, :share_appl_money, :pref_capital, :resand_surplus, :revaluation_reserve,
      :long_term_loan, :unsecured_term_loans, :unsecured_loans, :borrowings_by_bank, :cash_credits,
      :bills_purchased, :term_loans, :net_block, :capital_wip, :net_current_assets, :misc_exp_not_w_off,
      :investments, :cash_credits, :bills_purchased, :term_loans, :cash_and_bank_balance,
      :money_at_call_short_notice, :raw_inventory, :wip_inventory, :finished_goods_inventory,
      :other_inventory, :excise, :operating_income, :other_recurring_income, :non_recurring_income,
      :adjusted_pbdit, :financial_expences, :extr_ordinary_items, :layoffretrench_vrs, :insuranceclaims,
      :reported_net_profit, :numberof_equity_shares
    ].each do |attr|                                          ##
      define_method "#{attr}!" do                             # def attr!
        send(attr) || 0.0                                     #   attr || 0.0
      end                                                     # end
    end                                                       ##

  def banking_company?
    @company ||= Company.where( company_code: companycode).first
    @company.major_sector == 2
  end
  def net_worth
    @net_worth ||= total_share_capital + resand_surplus!
    @net_worth += revaluation_reserve! unless banking_company?
    @net_worth
  end

  def total_share_capital
    @total_share_capital ||= equity_capital!+ share_appl_money! + pref_capital!
  end

  def total_debt
    long_term_loan! + unsecured_term_loans! unless banking_company?
  end

  def total_liabilities
    net_worth + ( banking_company? ? unsecured_loans! + borrowings_by_bank! : total_debt )
  end

  def advances
    (cash_credits! + bills_purchased!  + term_loans!) if banking_company?
  end

  def total_assets
    value = net_block! + capital_wip! + net_current_assets! + misc_exp_not_w_off! + investments!
    value += advances + cash_and_bank_balance! + money_at_call_short_notice! if banking_company?
    value
  end

  def inventory
    raw_inventory! + wip_inventory! + finished_goods_inventory! + other_inventory!
  end

  def sales
    operating_income!+ excise! unless banking_company?
  end

  def other_income
    other_recurring_income! + non_recurring_income! unless banking_company?
  end

  def total_income
    operating_income!+ other_recurring_income!+ non_recurring_income! unless banking_company?
  end

  def pbdt
    adjusted_pbdit! - financial_expences! unless banking_company?
  end

  def extra_ordinary_items
    extr_ordinary_items! + layoffretrench_vrs! + insuranceclaims! unless banking_company?
  end

  def earnings_per_share
    (reported_net_profit / numberof_equity_shares).round(2) if reported_net_profit && numberof_equity_shares
  end
end