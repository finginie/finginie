class NavMaster
  include Mongoid::Document
  extend MongoidHelpers

  field  :security_code, :type => BigDecimal
  field  :scheme_code, :type => Float
  field  :scheme_plan_code, :type => Integer
  field  :scheme_plan_description
  field  :ticker_name
  field  :mapping_code
  field  :map_name
  field  :issue_price, :type => Float
  field  :description
  field  :issue_date, :type => DateTime
  field  :expiry_date, :type => DateTime
  field  :face_value, :type => Float
  field  :market_lot, :type => Float
  field  :isin_code
  field  :bench_mark_index
  field  :bench_mark_index_name
  field  :modified_date, :type => DateTime
  field  :delete_flag

  key :security_code
end
