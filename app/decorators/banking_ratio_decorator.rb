class BankingRatioDecorator < ApplicationDecorator
  decorates :banking_ratio

  RATIO_GROUPS = { 'EARNINGS RATIOS' =>     [ 'income_from_fund_advances_as_a_per_of_op_income',
                                              'operating_income_as_a_per_of_working_funds',
                                              'fund_based_income_as_a_per_of_op_income',
                                              'fee_based_income_as_a_per_of_op_income' ],
                  'PROFITABLITY RATIOS' =>  [ 'yield_on_fund_advances',
                                              'break_even_yield_ratio',
                                              'cost_of_funds_ratio',
                                              'net_profit_margin',
                                              'reported_return_on_net_worth',
                                              'adjusted_return_on_net_worth' ],
                  'BORROWING RATIOS' =>     [ 'borrowings_from_rbi_as_per_to_total_borrowings',
                                              'borrowings_from_other_banks_as_a_per_to_total_borrowings',
                                              'borrowings_from_others_as_a_per_to_total_borrowings',
                                              'borrowings_within_india_as_a_per_to_total_borrowings',
                                              'borrowings_from_outside_india_as_a_per_to_total_borrowings' ],
                  'DEPOSIT RATIOS' =>       [ 'demand_deposit_of_total_deposits',
                                              'saving_deposit_of_total_deposits',
                                              'time_deposit_of_total_deposits',
                                              'deposits_within_india_as_per_to_total_deposits',
                                              'deposits_outside_india_as_per_to_total_deposits' ],
                  'PER BRANCH RATIOS' =>    [ 'operating_income_per_branch',
                                              'operating_profit_per_branch',
                                              'net_profit_per_branch',
                                              'personnel_expenses_per_branch',
                                              'adminstrative_expenses_per_branch',
                                              'financial_expenses_per_branch',
                                              'borrowings_per_branch',
                                              'deposits_per_branch' ],
                  'PER EMPLOYEE RATIOS' =>  [ 'operating_income_per_employee',
                                              'operating_profit_per_employee',
                                              'net_profit_per_employee',
                                              'personnel_expenses_per_employee',
                                              'deposits_per_employee',
                                              'fund_advances_per_employee' ] }
  def view_items
    RATIO_GROUPS
  end

  RATIO_GROUPS.values.flatten.each do |attr|
    define_method "#{attr}" do
      model.send(attr) ? model.send(attr).round(2) : h.t('not_available')
    end
  end

end
