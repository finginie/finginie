require 'redis_record'

class Scrip < RedisRecord
  integer   :best_buy_quantity, :best_sell_quantity, :volume
  decimal   :best_buy_price, :best_sell_price, :last_traded_price, :net_change,
            :percent_change, :open_price, :high_price, :low_price, :close_price
  string    :id, :company_name
  datetime  :time

  search_by_range_on :last_traded_price
  search_by_range_on :percent_change
end
