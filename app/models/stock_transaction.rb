class StockTransaction < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :stock

  validates_presence_of :date, :stock_id, :action
  validate  :date_should_not_be_in_the_future, :sell_quantity_should_be_less_than_or_equal_to_quantity
  validates :price, :numericality => {:greater_than => 0}, :presence => true
  validates :quantity, :numericality => {:greater_than => 0}, :presence => true

  scope :for, lambda { |stock| where(:stock_id => stock).order(:date, :created_at) } do
    include MarketTradablePosition

    delegate :stock, :to => :first
    delegate :name, :sector, :current_price, :to => :stock
  end

  alias :security :stock

  include MarketTradableTransaction

private
  def sell_quantity_should_be_less_than_or_equal_to_quantity
    errors.add(:quantity, "Insufficient number of stocks for this action") if action == "sell" && portfolio.stock_transactions.for(stock.id).quantity < quantity
  end
end
