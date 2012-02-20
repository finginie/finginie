class QuarterlyResult
  include Mongoid::Document
  extend MongoidHelpers

  field :company_code, :type => Float
  field :year_ending, :type => Integer
  field :months, :type => Integer
  field :quarter, :type => Integer
  field :operating_income, :type => BigDecimal
  field :other_recurring_income, :type => BigDecimal
  field :stock_adjustment, :type => BigDecimal
  field :raw_material_consumed, :type => BigDecimal
  field :power_and_fuel, :type => BigDecimal
  field :employee_expenses, :type => BigDecimal
  field :excise, :type => BigDecimal
  field :admin_and_selling_expenses, :type => BigDecimal
  field :research_and_devlopment_expenses, :type => BigDecimal
  field :expenses_capitalised, :type => BigDecimal
  field :other_expeses, :type => BigDecimal
  field :bank_provisions_made, :type => BigDecimal
  field :interest_charges, :type => BigDecimal
  field :gross_profit, :type => BigDecimal
  field :depreciation, :type => BigDecimal
  field :tax_charges, :type => BigDecimal
  field :extra_ordinary_item, :type => BigDecimal
  field :reported_pat, :type => BigDecimal
  field :prior_year_adj, :type => BigDecimal
  field :reserves_written_back, :type => BigDecimal
  field :equity_capital, :type => BigDecimal
  field :reserves_and_surplus, :type => BigDecimal
  field :eq_dividend_rate, :type => BigDecimal
  field :aggregateof_non_promoto_no_of_shares, :type => BigDecimal
  field :aggregateof_non_promoto_holding_percent, :type => BigDecimal
  field :government_share, :type => BigDecimal
  field :capital_adequacy_ratio, :type => BigDecimal
  field :eps, :type => Float
  field :notes
  field :segment_notes
  field :modified_date, :type => DateTime

  key :company_code, :year_ending, :months, :quarter
end
