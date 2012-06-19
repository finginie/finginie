class FixedDepositDetail
  include ActiveAttr::Model

  attribute :min_duration,                    type: Integer
  attribute :max_duration,                    type: Integer
  attribute :rate_of_interest_general,        type: Float
  attribute :rate_of_interest_senior_citizen, type: Float
  attribute :min_amount,                      type: Integer
  attribute :max_amount,                      type: Integer
  attribute :bank,                            type: String
  attribute :sector,                          type: String
  attribute :amount,                          type: Float
  attribute :year,                            type: Integer
  attribute :month,                           type: Integer
  attribute :days,                            type: Integer

  validates :year,  :numericality => {:greater_than_or_equal_to => 0}, :allow_nil => true
  validates :amount,:numericality => {:greater_than => 0}
  validates :month, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 11}, :allow_nil => true
  validates :days,  :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 29}, :allow_nil => true

  attr_accessor :senior_citizen
end
