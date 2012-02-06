class ShareHolding
  include Mongoid::Document

  field :company_code, :type => Float
  field :share_holding_date, :type => Date
  field :modifyon, :type => DateTime
  field :element

  key :company_code, :share_holding_date
end
