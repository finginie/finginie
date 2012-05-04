module FungiblePosition
  def quantity
    sum(&:amount)
  end

  def current_value
    quantity && current_price ? quantity * current_price : 0.0
  end

  def profit_or_loss
    sells.map(&:profit_or_loss).inject(:+)
  end

  def profit_or_loss_percentage
    (sells.map(&:profit_or_loss).inject(:+) * 100 / sells.map { |s| s.adjusted_average_price * s.quantity }.inject(:+)).round(2).to_f unless sells.empty?
  end

  def average_cost_price
    last ? last.adjusted_average_price : 0
  end

  def average_sell_price
    sells.empty? ? 0 : (sells.sum("price * quantity").to_f / sells.sum(:quantity)).round(2)
  end

  def value
    average_cost_price * quantity
  end

  def unrealised_profit
    current_price ? (current_value - value) : nil
  end

  def unrealised_profit_percentage
    unrealised_profit ? (unrealised_profit / value * 100).round(2) : nil
  end
end
