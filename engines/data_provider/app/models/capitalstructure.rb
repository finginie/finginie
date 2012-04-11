class Capitalstructure
  include Mongoid::Document
  extend MongoidHelpers

  field :company_code, :type => Float
  field :modifyon, :type => DateTime
  field :element

  key :company_code
end
