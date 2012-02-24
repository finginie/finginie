class FundMaster
  include Mongoid::Document
  extend MongoidHelpers

  field :company_code, :type => BigDecimal
  field :company_name
  field :sponser_name
  field :trustee_company_name
  field :mf_set_up_date, :type => Date
  field :amc_code, :type => BigDecimal
  field :amc_name
  field :amc_inc_date, :type => Date
  field :ceo_name
  field :cio_name
  field :fund_manager_name
  field :compliance_officer_name
  field :inv_service_officer_name
  field :auditors_name
  field :custodian_name
  field :registrar_name
  field :type_of_mutual_fund
  field :modified_date, :type => DateTime
  field :delete_flag

  key :company_code
end
