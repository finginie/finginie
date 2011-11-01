require 'redis_record'

class Scrip < RedisRecord
  integer   :id, :best_buy_qty, :best_sell_qty, :volume
  decimal   :best_buy_price, :best_sell_price, :last_traded_price, :net_change,
            :percent_change, :open_price, :high_price, :low_price, :close_price
  string    :symbol, :company_name
  datetime  :time
end
