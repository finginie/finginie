class RatioDecorator < ApplicationDecorator
  decorates :ratio

  RATIO_GROUPS = { 'COMPONENT RATIOS' =>    [ 'bonus_in_equity_capital',
                                              'imported_compof_rawmaterialconsumed',
                                              'long_term_assets',
                                              'material_cost_composition',
                                              'sell_distribut_cost_comp',
                                              'exp_as_total_sales' ],
                  'COVERAGE RATIOS' =>      [ 'adjusted_cash_flow_times',
                                              'financial_charges_coverage_ratio_post_tax',
                                              'financial_charges_coverage_ratio',
                                              'interest_coverage',
                                              'interest_spread',
                                              'capital_adequacy_ratio' ],
                  'LEVERAGE RATIOS' =>      [ 'long_term_debt_equity',
                                              'owners_fund',
                                              'total_debtto_ownersfund',
                                              'debt_ratio',
                                              'averagecostoffunds' ],
                  'LIQUIDITY RATIOS' =>      [ 'current_ratio',
                                               'current_ratio_incl_short_term_loans',
                                               'investments_turn_ratio',
                                               'quick_ratio',
                                               'no_of_daysin_workingcap' ],
                  'PAYOUT RATIOS' =>         [ 'cash_earning_retention_ratio',
                                               'dividend_payout_ratio_cp',
                                               'dividend_payout_ratio_np',
                                               'earning_retention_ratio' ],
                  'PER SHARE RATIOS' =>      [ 'adjusted_cash_eps',
                                               'adjusted_eps',
                                               'book_value_per_share',
                                               'dividend_per_share',
                                               'free_reserves_per_share',
                                               'net_operating_income_per_share',
                                               'op_profit_per_share',
                                               'reported_cash_eps',
                                               'reported_eps',
                                               'price_to_sales',
                                               'div_yield_per' ],
                  'PROFITABILITY RATIOS' =>  [ 'roa_per',
                                               'roe_per',
                                               'adjusted_cash_margin',
                                               'adjusted_return_on_networth',
                                               'gross_profit_margin',
                                               'net_profit_margin',
                                               'operating_margin',
                                               'reported_return_on_net_worth',
                                               'returnon_long_term_fund',
                                               'enterprise_value_to_core_ebitda',
                                               'average_yieldon_assets',
                                               'average_returnon_investments' ],
                  'EFFICIENCY RATIOS' =>     [ 'asset_turnover_ratio' ]
  }

  def view_items
    RATIO_GROUPS
  end

  RATIO_GROUPS.values.flatten.each do |attr|
    define_method "#{attr}" do
      model.send(attr) ? model.send(attr).round(2) : h.t('tables_not_available')
    end
  end

end
