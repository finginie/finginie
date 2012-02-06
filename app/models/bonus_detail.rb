class BonusDetail
  include Mongoid::Document

  field :company_code, :type => Float
  field :year_ending, :type => Date
  field :ratio
  field :xb_date, :type => Date
  field :modified_date, :type => DateTime

  key :company_code, :year_ending
end
