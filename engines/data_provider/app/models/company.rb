require 'kaminari'
require 'kaminari/models/mongoid_extension'

class Company
  include Mongoid::Document
  include Mongoid::Search

  include Kaminari::MongoidExtension::Criteria
  include Kaminari::MongoidExtension::Document
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
  field :eps, :type => Float
  field :price_to_book_value, :type => Float
  field :book_value, :type => Float
  field :face_value, :type => Float
  field :market_capitalization, :type => BigDecimal
  field :dividend_yield, :type => Float

  key :company_code

  search_in :company_name, :industry_name, :bse_code1, :bse_code2, :nse_code, { :match => :all }

  validates_presence_of :company_code, :company_name
  validates_uniqueness_of :company_code, :company_name

  scope :stocks, where(:product_status_code.ne => "2161").any_of( { :nse_code.nin => [nil, ""]}, { :bse_code1.nin => [ nil, ""] } )
  scope :nse_stocks, where(:product_status_code.ne => "2161", :nse_code.nin => [nil, ""])

  SCRIP_METHODS = [ :last_traded_price, :percent_change, :net_change, :volume, :open_price, :high_price, :low_price, :close_price,
                    :best_buy_price, :best_buy_quantity, :best_sell_price, :best_sell_quantity, :time ]
  delegate *SCRIP_METHODS, :to => :scrip, :allow_nil => true

  SCRIP_BSE_METHODS = [ :bse_last_traded_price, :bse_net_change, :bse_percent_change, :bse_open_price,
                        :bse_high_price, :bse_low_price, :bse_close_price, :bse_volume, :bse_time ]
  delegate *SCRIP_BSE_METHODS, :to => :scrip_bse, :allow_nil => true
  alias :name :company_name
  alias :sector :industry_name

  def scrip
    Scrip.find(nse_code)
  end

  def scrip_bse
    ScripBse.find(ticker_name)
  end

  def current_price
    last_traded_price || bse_last_traded_price
  end

  def self.find_by_company_code(code)
    where(company_code: code).first
  end

  def self.find_by_company_name(name)
    where(company_name: name ).first
  end

  def news_headlines
    News.for_company(company_code).latest(5).map { |news| news.headlines }
  end

  def share_holding
    ShareHolding.all(conditions: { company_code: company_code }, sort: [[ :share_holding_date, :desc ]], limit: 1).first
  end

end
