require 'kaminari/models/mongoid_extension'

class Scheme
  include Mongoid::Document
  include Mongoid::Search

  include Kaminari::MongoidExtension::Criteria
  include Kaminari::MongoidExtension::Document
  extend MongoidHelpers

  field :securitycode, :type => BigDecimal
  field :scheme_code, :type => Float # from NavMaster.xml
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
  ###### from NavMaster.xml
  field :ticker_name     #take :ticker from Navcps.xml
  field :mapping_code
  field :map_name
  field :issue_price, :type => Float
  field :description
  field :issue_date, :type => DateTime
  field :expiry_date, :type => DateTime
  field :face_value, :type => Float
  field :market_lot, :type => Float
  field :isin_code
  field :bench_mark_index
  field :bench_mark_index_name
### from Navcps.xml
  field :datetime, :type => DateTime
  field :nav_amount, :type => BigDecimal
  field :repurchase_load, :type => Integer
  field :repurchase_price, :type => BigDecimal
  field :sale_load, :type => Integer
  field :sale_price, :type => BigDecimal
  field :prev_nav_amount, :type => BigDecimal
  field :prev_repurchase_price, :type => BigDecimal
  field :prev_sale_price, :type => BigDecimal
  field :percentage_change, :type => Float
  field :prev1_week_amount, :type => BigDecimal
  field :prev1_week_per, :type => Float
  field :prev1_month_amount, :type => BigDecimal
  field :prev1_month_per, :type => Float
  field :prev3_months_amount, :type => BigDecimal
  field :prev3_months_per, :type => Float
  field :prev6_months_amount, :type => BigDecimal
  field :prev6_months_per, :type => Float
  field :prev9_months_amount, :type => BigDecimal
  field :prev9_months_per, :type => Float
  field :prev_year_amount, :type => BigDecimal
  field :prev_year_per, :type => Float
  field :prev2_year_amount, :type => BigDecimal
  field :prev2_year_per, :type => Float
  field :prev2_year_comp_per, :type => Float
  field :prev3_year_amount, :type => BigDecimal
  field :prev3_year_per, :type => Float
  field :prev3_year_comp_per, :type => BigDecimal
  field :list_date, :type => DateTime
  field :list_amount, :type => BigDecimal
  field :list_per, :type => Float
  field :rank, :type => Integer

  field :objective #from MfObjective.xml

  key :securitycode

  search_in :scheme_name, { :match => :all }


  CATEGORY_METHODS = [ :one_day_return, :one_week_return, :one_month_return, :three_months_return, :six_months_return, :nine_months_return, :one_year_return,
    :two_year_return, :three_year_return ]
  delegate *CATEGORY_METHODS, :to => :category_wise_net_asset_value_detail, :allow_nil => true

  delegate :company_name, :to => :asset_management_company, :allow_nil => true
  delegate :dividend_date, :to => :mf_dividend_detail, :allow_nil => true

  def asset_management_company
    AssetManagementCompany.where(company_code: company_code).first
  end

  def mf_dividend_detail
    MfDividendDetail.all(conditions: { securitycode: securitycode }, sort: [[ :dividend_date, :desc ]]).first
  end

  def dividend_percentage
    mf_dividend_detail.percentage if mf_dividend_detail
  end

  def day_change
   (nav_amount - prev_nav_amount) if nav_amount && prev_nav_amount
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
    portfolio_holdings.select { |p| p["InstrumentCode"] == "2089" } if portfolio_holdings && portfolio_holdings.length > 0
  end

  def industry(industry_code)
    IndustryMaster.where( industry_code: industry_code ).first
  end

  def broad_industry_name(industry_code)
    industry(industry_code).broad_industry_name if industry(industry_code)
  end

  def sectoral_allocation
    return nil unless equity_holdings && equity_holdings.length > 0
    allocation = Hash.new(0.0)
    equity_holdings.each { |p|  allocation[broad_industry_name(p["IndustryCode"])]+= p["Percentage"].to_f if broad_industry_name(p["IndustryCode"]) }
    allocation.each_key { |k| allocation[k] = allocation[k].round(2) }
    allocation.sort_by { |k,v| -v }.take(10)
  end

end
