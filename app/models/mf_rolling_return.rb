class MfRollingReturn
  include Mongoid::Document
  extend MongoidHelpers

  field  :security_code, :type => BigDecimal
  field  :nav_date, :type => DateTime
  field  :nav_amount, :type => BigDecimal
  field  :re_pur_price, :type => BigDecimal
  field  :sale_price, :type => BigDecimal
  field  :one_day_return, :type => BigDecimal
  field  :one_week_return, :type => BigDecimal
  field  :two_weeks_return, :type => BigDecimal
  field  :one_month_return, :type => BigDecimal
  field  :three_months_return, :type => BigDecimal
  field  :six_months_return, :type => BigDecimal
  field  :nine_months_return, :type => BigDecimal
  field  :one_year_return, :type => BigDecimal
  field  :two_year_return, :type => BigDecimal
  field  :three_year_return, :type => BigDecimal
  field  :modified_date, :type => DateTime
  field  :delete_flag

  key :security_code, :nav_date
end
