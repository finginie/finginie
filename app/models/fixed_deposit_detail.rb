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

  attr_accessor :senior_citizen
end
