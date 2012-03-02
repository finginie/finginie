class StockTransaction < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :stock

  validates_presence_of :price, :quantity, :date
  validates_numericality_of :price, :quantity
  validate  :date_should_not_be_in_the_future

  scope :for, lambda { |stock| where(:stock_id => stock).order(:date) } do
    def quantity
      sum(&:quantity)
    end

    def name
      first.stock.name
    end

    def current_price
      first.stock.current_price
    end

    def current_value
      quantity * current_price
    end

    def buy_transactions
      all.select { |t|  t.quantity > 0 }
    end

    def sell_transactions
      all.select { |t| t.quantity < 0 }
    end

    def profit_or_loss
      sell_transactions.map { |t| - t.quantity * (t.price - average_price(t)) }.inject(:+)
    end

    def average_cost_price
      all.map { |t| average_price(t) * t.quantity }.inject(:+) /quantity
    end

    def total_cost
      average_cost_price * quantity
    end

    def prev_buy_transactions(transaction)
      buy_transactions.select { |t| t.date < transaction.date }
    end

    def average_price(transaction)
      price = ( transaction.quantity < 0 ) ?
        (prev_buy_transactions(transaction).map{ |t| t.price * t.quantity }.inject(:+) /prev_buy_transactions(transaction).sum(&:quantity) ) :
          transaction.price
    end

    def unrealised_profit
      current_value - total_cost
    end
  end

  def profit_or_loss
    (- quantity * ( price - StockTransaction.for(stock).average_price(self) ) )if quantity < 0
  end

  def total_cost
    amount * price
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
end
