class MutualFundTransaction < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :mutual_fund

  validates_presence_of :date, :action
  validate  :date_should_not_be_in_the_future, :sell_quantity_should_be_less_than_or_equal_to_quantity
  validates :price, :numericality => {:greater_than => 0}, :presence => true
  validates :quantity, :numericality => {:greater_than => 0}, :presence => true

  scope :for, lambda { |name| where("mutual_fund_id = ?", MutualFund.find_by_name(name)).order(:date, :created_at) } do
    include MarketTradablePosition

    delegate :mutual_fund, :to => :first
    delegate :name, :category, :current_price, :to => :mutual_fund
  end

  def mutual_fund
    super || build_mutual_fund
  end
  alias :security :mutual_fund

  include MarketTradableTransaction

private
  def sell_quantity_should_be_less_than_or_equal_to_quantity
    errors.add(:quantity, "Insufficient number of units for this action") if action == "sell" && portfolio.mutual_fund_transactions.for(mutual_fund.name).quantity < quantity
  end
end
