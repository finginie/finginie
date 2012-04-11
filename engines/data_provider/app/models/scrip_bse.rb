require 'redis_record'

class ScripBse < RedisRecord
  integer   :bse_volume
  decimal   :bse_last_traded_price, :bse_open_price, :bse_high_price, :bse_low_price, :bse_close_price
  string    :id
  datetime  :bse_time

  search_by_range_on :bse_last_traded_price
end
