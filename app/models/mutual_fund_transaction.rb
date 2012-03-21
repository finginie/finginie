class MutualFundTransaction < ActiveRecord::Base
  include MarketTradableTransaction

  belongs_to :portfolio
  belongs_to :mutual_fund

  validates_presence_of :mutual_fund_id

  scope :for, lambda { |mutual_fund| where(:mutual_fund_id => mutual_fund.id).order(:date, :created_at) } do
    include MarketTradablePosition

    delegate :mutual_fund, :to => :first
    delegate :name, :category, :current_price, :to => :mutual_fund
  end

  def scheme
    @scheme ||= mutual_fund && mutual_fund.name
  end

  def scheme=(name)
    self.mutual_fund = MutualFund.find_or_create_by_name(name)
    @scheme = name
  end

  alias :security :mutual_fund
end
