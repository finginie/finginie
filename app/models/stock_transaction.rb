class StockTransaction < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :stock

  validates_presence_of :price, :quantity

  scope :for, lambda { |stock| where(:stock_id => stock).order(:date) } do
    def quantity
      sum(&:quantity)
    end

    def name
      first.stock.name
    end

    def current_value
      quantity * first.stock.current_price
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
end
