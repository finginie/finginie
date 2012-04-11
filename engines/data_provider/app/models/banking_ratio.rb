class BankingRatio
  include Mongoid::Document
  extend MongoidHelpers

  field :company_code, :type => Float
  field :year_ending, :type => Date
  field :months, :type => Integer
  field :type
  field :face_value, :type => Integer
  field :capital_adequacy_ratio, :type => BigDecimal
  field :income_from_fund_advances_as_a_per_of_op_income, :type => BigDecimal
  field :operating_income_as_a_per_of_working_funds, :type => BigDecimal
  field :fund_based_income_as_a_per_of_op_income, :type => BigDecimal
  field :fee_based_income_as_a_per_of_op_income, :type => BigDecimal
  field :yield_on_fund_advances, :type => BigDecimal
  field :break_even_yield_ratio, :type => BigDecimal
  field :cost_of_funds_ratio, :type => BigDecimal
  field :net_profit_margin, :type => BigDecimal
  field :reported_return_on_net_worth, :type => BigDecimal
  field :adjusted_return_on_net_worth, :type => BigDecimal
  field :borrowings_from_rbi_as_per_to_total_borrowings, :type => BigDecimal
  field :borrowings_from_other_banks_as_a_per_to_total_borrowings, :type => BigDecimal
  field :borrowings_from_others_as_a_per_to_total_borrowings, :type => BigDecimal
  field :borrowings_within_india_as_a_per_to_total_borrowings, :type => BigDecimal
  field :borrowings_from_outside_india_as_a_per_to_total_borrowings, :type => BigDecimal
  field :demand_deposit_of_total_deposits, :type => BigDecimal
  field :saving_deposit_of_total_deposits, :type => BigDecimal
  field :time_deposit_of_total_deposits, :type => BigDecimal
  field :deposits_within_india_as_per_to_total_deposits, :type => BigDecimal
  field :deposits_outside_india_as_per_to_total_deposits, :type => BigDecimal
  field :operating_income_per_branch, :type => BigDecimal
  field :operating_profit_per_branch, :type => BigDecimal
  field :net_profit_per_branch, :type => BigDecimal
  field :personnel_expenses_per_branch, :type => BigDecimal
  field :adminstrative_expenses_per_branch, :type => BigDecimal
  field :financial_expenses_per_branch, :type => BigDecimal
  field :borrowings_per_branch, :type => BigDecimal
  field :deposits_per_branch, :type => BigDecimal
  field :operating_income_per_employee, :type => BigDecimal
  field :operating_profit_per_employee, :type => BigDecimal
  field :net_profit_per_employee, :type => BigDecimal
  field :personnel_expenses_per_employee, :type => BigDecimal
  field :deposits_per_employee, :type => BigDecimal
  field :fund_advances_per_employee, :type => BigDecimal
  field :modified_date, :type => BigDecimal

  key :company_code, :year_ending
end
