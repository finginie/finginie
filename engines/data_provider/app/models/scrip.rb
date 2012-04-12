require 'redis_record'

class Scrip < RedisRecord
  integer   :best_buy_quantity, :best_sell_quantity, :volume
  decimal   :best_buy_price, :best_sell_price, :last_traded_price,
            :open_price, :high_price, :low_price, :close_price
  string    :id, :company_name
  datetime  :time

  def net_change
    @net_change ||= last_traded_price - close_price if close_price != 0
  end

  def percent_change
    @percent_change ||= (net_change / close_price * 100).round(2) if net_change && close_price != 0
  end

  search_by_range_on :last_traded_price
end
