class KeyExecutive
  include Mongoid::Document
  extend MongoidHelpers

  field :company_code, :type => Float
  field :modify_on, :type => DateTime
  field :element

  key :company_code
end
