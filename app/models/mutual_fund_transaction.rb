class MutualFundTransaction < ActiveRecord::Base
  include MarketTradableTransaction

  belongs_to :portfolio
  belongs_to :mutual_fund

  scope :for, lambda { |mutual_fund| where(:mutual_fund_id => mutual_fund.id).order(:date, :created_at) } do
    include MarketTradablePosition

    delegate :mutual_fund, :to => :first
    delegate :name, :category, :current_price, :to => :mutual_fund
  end

  def scheme
    @scheme ||= mutual_fund.name
  end

  def scheme=(name)
    mutual_fund = MutualFund.find_or_create_by_name(name)
    @scheme = name
  end

  def mutual_fund
    super || build_mutual_fund
  end
  alias :security :mutual_fund
end
