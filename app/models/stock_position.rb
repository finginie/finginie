module StockPosition

  delegate :name, :sector, :current_price, :to => :stock

  def stock
    last.stock
  end

  def quantity
    sum(:quantity)
  end

  def current_value
    quantity && current_price ? quantity * current_price : 0
  end

  def profit_or_loss
    sells.map(&:profit_or_loss).inject(:+)
  end

  def average_cost_price
    last ? last.adjusted_average_price : 0
  end

  def value
    average_cost_price * quantity
  end

  def unrealised_profit
    current_value - value
  end
end
