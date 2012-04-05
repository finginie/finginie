class Company
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
  # from CurrDetails.xml
  field :pe, :type => Float
  field :fifty_two_week_high_price, :type => Float
  field :fifty_two_week_low_price, :type => Float
  field :eps, :type => Float

  key :company_code

  validates_presence_of :company_code, :company_name
  validates_uniqueness_of :company_code, :company_name

  SCRIP_METHODS = [ :last_traded_price, :percent_change, :net_change, :volume, :open_price, :high_price, :low_price, :close_price,
                    :best_buy_price, :best_buy_quantity, :best_sell_price, :best_sell_quantity, :time ]
  delegate *SCRIP_METHODS, :to => :scrip, :allow_nil => true

  def scrip
    Scrip.find(nse_code)
  end

  def current_price
    last_traded_price
  end

end
