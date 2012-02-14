class Subsidiary
  include Mongoid::Document
  extend MongoidHelpers

  field :company_code, :type => Float
  field :company_name
  field :parent_company_code, :type => Float
  field :parent_company_name
  field :modified_date, :type => DateTime
  field :deleteflag

  key :company_code, :parent_company_code
end
