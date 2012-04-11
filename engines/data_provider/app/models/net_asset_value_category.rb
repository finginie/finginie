class NetAssetValueCategory
  include Mongoid::Document
  extend MongoidHelpers

  field  :scheme_class_code, :type => BigDecimal
  field  :scheme_class_description
  field  :no_of_schemes, :type => Integer
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

  key :scheme_class_code
end
