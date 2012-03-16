class StockTransaction < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :stock


  validates_presence_of :price, :quantity, :date
  validates_numericality_of :price, :quantity
  validate  :date_should_not_be_in_the_future, :sell_quantity_should_be_less_than_or_equal_to_quantity

  scope :buys, where("quantity >= ?", 0)
  scope :sells, where("quantity < ?", 0)
  scope :before, lambda { |date| where('date < ?', date) }

  scope :for, lambda { |stock| where(:stock_id => stock).order(:date) } do
    include StockPosition
  end

  def profit_or_loss
    (- quantity * ( price - StockTransaction.for(stock).average_price(self) ) ) if quantity < 0
  end

  def value
    quantity * price
  end

  def action
    (quantity < 0 ? :sell : :buy) if quantity
  end
  def action=(action)
    set_quantity(amount, action)
    action
  end

  def amount
    quantity && quantity.abs
  end
  def amount=(amount)
    set_quantity(amount, action)
    amount
  end

private
  def set_quantity(amount, action)
    action ||= :buy
    amount ||= 1
    self.quantity = { :buy => 1, :sell => -1}[action.to_sym] * amount.to_i
  end

  def date_should_not_be_in_the_future
    errors.add(:date, "can't be in the future") if !date.blank? and date > Date.today
  end

  def sell_quantity_should_be_less_than_or_equal_to_quantity
    errors.add(:amount, "Your portfolio do not have sufficient number of stocks for this action") if action == :sell && portfolio.stock_transactions.for(stock.id).quantity < amount
  end
end
