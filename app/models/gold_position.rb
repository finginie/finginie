module GoldPosition
  def quantity
    all.sum(&:quantity)
  end

  def name
    first.gold.name
  end

  def current_price
    all.empty? ? 0.0 : first.gold.current_price
  end

  def current_value
    quantity * current_price
  end

  def buy_transactions
    all.select { |t|  t.quantity > 0 }
  end

  def sells
    all.select { |t| t.quantity < 0 }
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

  def prev_buy_transactions(transaction)
    buy_transactions.select { |t| t.date < transaction.date }
  end

  def average_price(transaction)
    price = ( transaction.quantity < 0 ) ?
      (prev_buy_transactions(transaction).map{ |t| t.price * t.quantity }.inject(:+) /prev_buy_transactions(transaction).sum(&:quantity) ) :
        transaction.price
  end

  def unrealised_profit
    current_value - value
  end
end
