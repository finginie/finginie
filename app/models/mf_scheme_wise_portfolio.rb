class MfSchemeWisePortfolio
  include Mongoid::Document

  field :security_code, :type => BigDecimal
  field :holding_date, :type => Date
  field :modifyon, :type => DateTime
  field :element

  key :security_code, :holding_date
end
