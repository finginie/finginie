class Rawmaterial
  include Mongoid::Document
  extend MongoidHelpers

  field :company_code, :type => Float
  field :year_ending, :type => Date
  field :modifyon, :type => DateTime
  field :element

  key :company_code, :year_ending
end
