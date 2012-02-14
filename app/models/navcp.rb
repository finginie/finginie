class Navcp
  include Mongoid::Document
  extend MongoidHelpers

  field  :security_code, :type => BigDecimal
  field  :ticker
  field  :scheme_type, :type => Integer
  field  :scheme_type_description
  field  :datetime, :type => DateTime
  field  :nav_amount, :type => BigDecimal
  field  :repurchase_load, :type => Integer
  field  :repurchase_price, :type => BigDecimal
  field  :sale_load, :type => Integer
  field  :sale_price, :type => BigDecimal
  field  :prev_nav_amount, :type => BigDecimal
  field  :prev_repurchase_price, :type => BigDecimal
  field  :prev_sale_price, :type => BigDecimal
  field  :percentage_change, :type => Float
  field  :prev1_week_amount, :type => BigDecimal
  field  :prev1_week_per, :type => Float
  field  :prev1_month_amount, :type => BigDecimal
  field  :prev1_month_per, :type => Float
  field  :prev3_months_amount, :type => BigDecimal
  field  :prev3_months_per, :type => Float
  field  :prev6_months_amount, :type => BigDecimal
  field  :prev6_months_per, :type => Float
  field  :prev9_months_amount, :type => BigDecimal
  field  :prev9_months_per, :type => Float
  field  :prev_year_amount, :type => BigDecimal
  field  :prev_year_per, :type => Float
  field  :prev2_year_amount, :type => BigDecimal
  field  :prev2_year_per, :type => Float
  field  :prev2_year_comp_per, :type => Float
  field  :prev3_year_amount, :type => BigDecimal
  field  :prev3_year_per, :type => Float
  field  :prev3_year_comp_per, :type => BigDecimal
  field  :list_date, :type => DateTime
  field  :list_amount, :type => BigDecimal
  field  :list_per, :type => Float
  field  :rank, :type => Integer

  key :security_code, :datetime
end
