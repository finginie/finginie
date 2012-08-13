class ResearchReport < ActiveRecord::Base
  include CurrencyFormatter

  SELL       = 1
  NEUTRAL    = 2
  ACCUMULATE = 3
  BUY        = 4

  RECOMMENDATION = {
    SELL       => 'Sell',
    NEUTRAL    => 'Neutral',
    ACCUMULATE => 'Accumulate',
    BUY        => 'Buy'
  }

  monetize :current_market_price, :target_price

  def recommendation_value
    RECOMMENDATION.select {|k,v| v == recommendation }.keys.first || 0
  end

  def self.short_term(company)
    where(:nse_code => company).where("date >= '#{Date.today.prev_month(3)}'")
  end
end
