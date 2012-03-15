module StockPosition

  delegate :name, :sector, :current_price, :to => :stock

  def stock
    first.stock
  end

  def quantity
    sum(:quantity)
  end

  def current_value
    quantity ? ( current_price ? quantity * current_price : 0 ) : 0
  end

  def profit_or_loss
    sells.map { |t| - t.quantity * (t.price - average_price(t)) }.inject(:+)
  end

  def average_cost_price
    all.map { |t| average_price(t) * t.quantity }.inject(:+) /quantity
  end

  def value
    average_cost_price * quantity
  end

  def average_price(transaction)
    price = ( transaction.quantity < 0 ) ?
      (buys.before(transaction.date).sum(&:value) /buys.before(transaction.date).sum(:quantity) ) :
        transaction.price
  end

  def unrealised_profit
    current_value - value
  end
end
