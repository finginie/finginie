require 'kaminari/models/mongoid_extension'

class SchemeMaster
  include Mongoid::Document
  include Mongoid::Search

  include Kaminari::MongoidExtension::Criteria
  include Kaminari::MongoidExtension::Document
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

  search_in :scheme_name, { :match => :all }

  NAVCP_METHODS = [ :nav_amount, :prev_nav_amount, :percentage_change, :prev1_week_per, :prev1_month_per, :prev3_months_per, :prev6_months_per, :prev9_months_per, :prev_year_per,
    :prev2_year_comp_per, :prev3_year_comp_per]
  delegate *NAVCP_METHODS, :to => :net_asset_value_current_price, :allow_nil => true

  CATEGORY_METHODS = [ :one_day_return, :one_week_return, :one_month_return, :three_months_return, :six_months_return, :nine_months_return, :one_year_return,
    :two_year_return, :three_year_return ]
  delegate *CATEGORY_METHODS, :to => :category_wise_net_asset_value_detail, :allow_nil => true

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

  def day_change
   (nav_amount - net_asset_value_current_price.prev_nav_amount) if nav_amount && prev_nav_amount
  end

  def category_wise_net_asset_value_detail
    NavCategoryDetail.all(conditions: { scheme_class_code: scheme_class_code }, sort: [[ :modified_date, :desc ]]).first
  end

  def scheme_portfolio
    MfSchemeWisePortfolio.all( conditions: { security_code: securitycode }, sort: [[ :holding_date, :desc ]]).first
  end

  def portfolio_holdings
    [ scheme_portfolio.element ].flatten.sort_by { |hsh| -hsh["Percentage"].to_f } if scheme_portfolio
  end

  def asset_allocation
    return nil if !scheme_portfolio
    groupwise_percentage = Hash.new(0.0)
    portfolio_holdings.each { |portfolio| groupwise_percentage[portfolio["InstrumentName"]] += portfolio["Percentage"].to_f }
    groupwise_percentage.each_key { |k| groupwise_percentage[k] = groupwise_percentage[k].round(2) }
  end

  def equity_holdings
    portfolio_holdings.select { |p| p["InstrumentCode"] == "2089" } if portfolio_holdings.length > 0
  end

  def industry(industry_code)
    IndustryMaster.where( industry_code: industry_code ).first
  end

  def broad_industry_name(industry_code)
    industry(industry_code).broad_industry_name if industry(industry_code)
  end

  def sectoral_allocation
    return nil if !equity_holdings
    allocation = Hash.new(0.0)
    equity_holdings.each { |p|  allocation[broad_industry_name(p["IndustryCode"])]+= p["Percentage"].to_f if broad_industry_name(p["IndustryCode"]) }
    allocation.each_key { |k| allocation[k] = allocation[k].round(2) }
    allocation.sort_by { |k,v| -v }.take(10)
  end

end
