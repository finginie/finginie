class FixedDepositQuery
  include ActiveAttr::Model

  attribute :amount,                          type: Float
  attribute :year,                            type: Integer
  attribute :month,                           type: Integer
  attribute :days,                            type: Integer

  validates :year,  :numericality => {:greater_than_or_equal_to => 0}, :allow_nil => true
  validates :amount,:numericality => {:greater_than => 0}
  validates :month, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 11}, :allow_nil => true
  validates :days,  :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 30}, :allow_nil => true

  attr_accessor :senior_citizen
end
