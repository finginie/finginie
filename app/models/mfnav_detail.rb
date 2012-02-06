class MfnavDetail
  include Mongoid::Document

  field  :security_code, :type => BigDecimal
  field  :nav_date, :type => DateTime
  field  :nav_amount, :type => BigDecimal
  field  :repurchase_load, :type => Integer
  field  :repurchase_price, :type => BigDecimal
  field  :sale_load, :type => Integer
  field  :sale_price, :type => BigDecimal
  field  :modified_date, :type => DateTime
  field  :delete_flag

  key :security_code, :nav_date
end
