class SchemeMaster
  include Mongoid::Document
  extend MongoidHelpers

  field :securitycode, :type => BigDecimal
  field :scheme_name
  field :company_code, :type => BigDecimal
  field :amc_code, :type => BigDecimal
  field :scheme_type, :type => Integer
  field :scheme_type_description
  field :launch_date, :type => DateTime
  field :scheme_plan_code, :type => Integer
  field :scheme_plan_description
  field :scheme_class_code, :type => Integer
  field :scheme_class_description
  field :open_date, :type => DateTime
  field :close_date, :type => DateTime
  field :redemption_date, :type => DateTime
  field :minimum_invement_amount, :type => Integer
  field :initial_price, :type => BigDecimal
  field :initial_price_uom, :type => Integer
  field :initial_price_uom_description
  field :size, :type => BigDecimal
  field :size_uom, :type => Integer
  field :size_uom_description
  field :offer_price, :type => BigDecimal
  field :amount_raised, :type => BigDecimal
  field :amount_raised_uom, :type => Integer
  field :amount_raised_uom_description
  field :fund_manager_prefix
  field :fund_manager_name
  field :listing_information
  field :entry_load
  field :exit_load
  field :redemption_ferq
  field :sip
  field :product_code
  field :modified_date, :type => DateTime
  field :delete_flag

  key :securitycode
end
