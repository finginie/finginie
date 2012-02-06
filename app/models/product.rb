class Product
  include Mongoid::Document

  field :company_code, :type => Float
  field :year_ending, :type => Date
  field :no_of_months, :type => Integer
  field :modifyon, :type => DateTime
  field :element

  key :company_code, :year_ending
end
