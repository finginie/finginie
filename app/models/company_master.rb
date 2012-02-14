class CompanyMaster
  include Mongoid::Document
  extend MongoidHelpers

    field :company_code, :type => Float
    field :company_name
    field :short_company_name
    field :ticker_name
    field :industry_code, :type => Integer
    field :industry_name
    field :business_group_code, :type => Integer
    field :business_group_name
    field :incorporation_date, :type => DateTime
    field :first_public_issue_date, :type => DateTime
    field :major_sector, :type => Integer
    field :isin_code
    field :security_code
    field :bse_code1
    field :bse_code2
    field :nse_code
    field :product_status_code
    field :modified_date, :type => DateTime
    field :delete_flag

    key :company_code

    validates_presence_of :company_code
end
