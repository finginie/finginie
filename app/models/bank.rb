class Bank
  include ActiveAttr::Model

  attribute :name,                      type: String
  attribute :sector,                    type: String
  attribute :one_month_interest_rate,   type: Float
  attribute :three_month_interest_rate, type: Float
  attribute :six_month_interest_rate,   type: Float
  attribute :one_year_interest_rate,    type: Float
end
