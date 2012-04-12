require 'redis_record'

class ScripBse < RedisRecord
  integer   :bse_volume
  decimal   :bse_last_traded_price, :bse_open_price, :bse_high_price, :bse_low_price, :bse_close_price
  string    :id
  datetime  :bse_time

  def bse_net_change
    @bse_net_change ||= bse_last_traded_price - bse_close_price if bse_close_price != 0
  end

  def bse_percent_change
    @bse_percent_change ||= (bse_net_change / bse_close_price * 100).round(2) if bse_close_price != 0
  end

  search_by_range_on :bse_last_traded_price
end
