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


  def fund_master
    FundMaster.where(company_code: company_code).first
  end

  def company_name
    fund_master.company_name if fund_master
  end

  def nav_master
    NavMaster.where( security_code: securitycode ).first
  end

  def bench_mark_index
    nav_master.bench_mark_index_name if nav_master
  end

  def mf_objective
    MfObjective.where(securitycode: securitycode).first
  end

  def objective
    mf_objective.objective if mf_objective
  end

  def mf_dividend_detail
    MfDividendDetail.all(conditions: { securitycode: securitycode }, sort: [[ :dividend_date, :desc ]]).first
  end

  def dividend_percentage
    mf_dividend_detail.percentage if mf_dividend_detail
  end

  def dividend_date
    mf_dividend_detail.dividend_date if mf_dividend_detail
  end

  def net_asset_value_current_price
    Navcp.all(conditions: { security_code: securitycode }, sort: [[ :datetime, :desc ]]).first
  end

  def nav_amount
    net_asset_value_current_price.nav_amount if net_asset_value_current_price
  end

  def percentage_change
    net_asset_value_current_price.percentage_change if net_asset_value_current_price
  end

  def prev_nav_amount
    net_asset_value_current_price.prev_nav_amount if net_asset_value_current_price
  end

  def day_change
   (nav_amount - net_asset_value_current_price.prev_nav_amount) if nav_amount && prev_nav_amount
  end

end
