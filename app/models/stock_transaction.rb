class StockTransaction < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :stock


  validates_presence_of :price, :quantity, :date
  validates_numericality_of :price, :quantity
  validate  :date_should_not_be_in_the_future, :sell_quantity_should_be_less_than_or_equal_to_quantity

  scope :buys, where("action = ?", "buy")
  scope :sells, where("action = ?", "sell")
  scope :before, lambda { |transaction|
    where('date < :date or ( date = :date and created_at < :created_at )',
        :date => transaction.date,
        :created_at => transaction.created_at
        ).order('date, created_at')
  }

  scope :for, lambda { |stock| where(:stock_id => stock).order("date ASC, created_at ASC") } do
    include StockPosition
  end

  def profit_or_loss
    @profit_or_loss ||= buy? ? 0 : quantity * ( price - adjusted_average_price )
  end

  def value
    quantity * price
  end

  def adjusted_average_price
    transactions = portfolio.stock_transactions.for(stock).before(self)
    @average_price ||= buy? ? ((transactions.value + value) / (transactions.quantity + quantity)).round(2) : transactions.average_cost_price
  end

  def buy?
    amount >= 0
  end

  def sell?
    amount < 0
  end

  def amount
    action.to_sym == :buy ? quantity : (quantity * -1)
  end

private
  def date_should_not_be_in_the_future
    errors.add(:date, "can't be in the future") if !date.blank? and date > Date.today
  end

  def sell_quantity_should_be_less_than_or_equal_to_quantity
    errors.add(:quantity, "Insufficient number of stocks for this action") if action == "sell" && portfolio.stock_transactions.for(stock.id).quantity < quantity
  end
end
