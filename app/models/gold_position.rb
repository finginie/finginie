module GoldPosition
  include MarketTradablePosition

  def name
    first.gold.name
  end

  def current_price
    all.empty? ? 0.0 : first.gold.current_price
  end
end
