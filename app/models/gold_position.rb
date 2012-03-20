module GoldPosition
  def quantity
    sum(&:amount)
  end

  def name
    first.gold.name
  end

  def current_price
    all.empty? ? 0.0 : first.gold.current_price
  end

  def current_value
    quantity && current_price ? quantity * current_price : 0
  end

  def profit_or_loss
    sells.map { |t| t.quantity * (t.price - average_price(t)) }.inject(:+)
  end

  def average_cost_price
    all.map { |t| average_price(t) * t.amount }.inject(:+) /quantity
  end

  def value
    average_cost_price * quantity
  end

  def average_price(transaction)
    price = ( transaction.amount < 0 ) ?
      (buys.before(transaction.date).map{ |t| t.price * t.quantity }.inject(:+) /buys.before(transaction.date).sum(&:quantity) ) :
        transaction.price
  end

  def unrealised_profit
    current_value - value
  end
end
