class MfDividendDetail
  include Mongoid::Document
  extend MongoidHelpers

  field :securitycode, :type => BigDecimal
  field :dividend_date, :type => Date
  field :percentage, :type => Float
  field :dividend_type, :type => Integer
  field :dividend_type_description
  field :remarks
  field :modified_date, :type => DateTime
  field :row_id, :type => Integer
  field :delete_flag

  key :securitycode, :dividend_date
end
