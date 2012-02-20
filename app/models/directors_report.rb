class DirectorsReport
  include Mongoid::Document
  extend MongoidHelpers

  field :company_code, :type => Float
  field :year_ending, :type => Date
  field :notes
  field :modified_date, :type => DateTime

  key :company_code, :year_ending
end
