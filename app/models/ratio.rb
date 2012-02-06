class Ratio
  include Mongoid::Document

  field :company_code, :type => Float
  field :year_ending, :type => Integer
  field :months, :type => Integer
  field :type
  field :face_value, :type => Integer
  field :adjusted_eps, :type => BigDecimal
  field :adjusted_cash_eps, :type => BigDecimal
  field :return_on_assets_excl, :type => BigDecimal
  field :return_on_assets_incl, :type => BigDecimal
  field :dividend_per_share, :type => BigDecimal
  field :reported_eps, :type => BigDecimal
  field :reported_cash_eps, :type => BigDecimal
  field :op_profit_per_share, :type => BigDecimal
  field :net_operating_income_per_share, :type => BigDecimal
  field :free_reserves_per_share, :type => BigDecimal
  field :operating_margin, :type => BigDecimal
  field :reported_return_on_net_worth, :type => BigDecimal
  field :adjusted_return_on_networth, :type => BigDecimal
  field :adjusted_cash_margin, :type => BigDecimal
  field :returnon_long_term_fund, :type => BigDecimal
  field :current_ratio, :type => BigDecimal
  field :quick_ratio, :type => BigDecimal
  field :average_raw_mat_holding, :type => BigDecimal
  field :averagefinished_goods_hold, :type => BigDecimal
  field :no_of_daysin_workingcap, :type => BigDecimal
  field :long_term_debt_equity, :type => BigDecimal
  field :owners_fund, :type => BigDecimal
  field :total_debtto_ownersfund, :type => BigDecimal
  field :current_ratio_incl_short_term_loans, :type => BigDecimal
  field :asset_turnover_ratio, :type => BigDecimal
  field :long_term_assets, :type => BigDecimal
  field :financial_charges_coverage_ratio, :type => BigDecimal
  field :financial_charges_coverage_ratio_post_tax, :type => BigDecimal
  field :dividend_payout_ratio_np, :type => BigDecimal
  field :dividend_payout_ratio_cp, :type => BigDecimal
  field :earning_retention_ratio, :type => BigDecimal
  field :cash_earning_retention_ratio, :type => BigDecimal
  field :material_cost_composition, :type => BigDecimal
  field :sell_distribut_cost_comp, :type => BigDecimal
  field :investments_turn_ratio, :type => BigDecimal
  field :adjusted_cash_flow_times, :type => BigDecimal
  field :imported_compof_rawmaterialconsumed, :type => BigDecimal
  field :exp_as_total_sales, :type => BigDecimal
  field :interest_spread, :type => BigDecimal
  field :operating_expby_op_income, :type => BigDecimal
  field :n_pby_operatin_income, :type => BigDecimal
  field :npby_capital_employed, :type => BigDecimal
  field :averagecostoffunds, :type => BigDecimal
  field :average_yieldon_assets, :type => BigDecimal
  field :average_returnon_investments, :type => BigDecimal
  field :gross_profit_margin, :type => BigDecimal
  field :net_profit_margin, :type => BigDecimal
  field :bonus_in_equity_capital, :type => BigDecimal
  field :capital_adequacy_ratio, :type => BigDecimal
  field :book_value_per_share, :type => BigDecimal
  field :price_to_sales, :type => BigDecimal
  field :div_yield_per, :type => BigDecimal
  field :enterprise_value_to_core_ebitda, :type => BigDecimal
  field :price_to_book_value, :type => BigDecimal
  field :debt_ratio, :type => BigDecimal
  field :roa_per, :type => BigDecimal
  field :roe_per, :type => BigDecimal
  field :pre_tax_margin_per, :type => BigDecimal
  field :interest_coverage, :type => BigDecimal
  field :opearing_cash_flow_to_debt_ratio, :type => BigDecimal
  field :operating_cash_flow_to_sales_ratio, :type => BigDecimal
  field :price_to_operating_cash_flow_ratio, :type => BigDecimal
  field :capitalization_ratio, :type => BigDecimal
  field :modified_date, :type => DateTime

  key :company_code, :year_ending
end
