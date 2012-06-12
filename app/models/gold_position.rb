module GoldPosition
  include FungiblePosition

  def name
    'Gold'
  end

  def current_price
    all.empty? ? 0.0 : first.gold.last_traded_price
  end
end
