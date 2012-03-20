module MutualFundPosition
  def quantity
    sum(&:amount)
  end

  def name
    first.mutual_fund.name
  end

  def category
    first.mutual_fund.category
  end

  def current_price
    first.mutual_fund.current_price
  end

  def current_value
    quantity && current_price ? quantity * current_price : 0
  end

  def profit_or_loss
    sells.map { |t| t.quantity * (t.price - average_price(t)) }.inject(:+)
  end

  def average_cost_price
    (all.map { |t| average_price(t) * t.amount }.inject(:+) / quantity).round(2) if quantity > 0
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
