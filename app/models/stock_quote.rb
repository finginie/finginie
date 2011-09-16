require 'active_model_object'

class StockQuote
  include ActiveModelObject
  attr_accessible :id, :symbol, :company_name, :time, :best_buy_qty, :best_buy_price, :best_sell_qty, :best_sell_price, :last_traded_price, :volume, :net_change, :percent_change, :open_price, :high_price, :low_price, :close_price

  def save
    @persisted = (REDIS.set("stock_quote:#{@id}", to_json) == "OK") 
  end

  def from_quote (tp_code, symbol, series, company_name, time, best_buy_qty, best_buy_price, best_sell_qty, best_sell_price, last_traded_price, volume, net_change, percent_change, open_price, high_price, low_price, close_price)
    self.attributes = {
      :id => tp_code.to_i,
      :symbol => symbol,
      :company_name => company_name,
      :time => DateTime.parse(time),
      :best_buy_qty => best_buy_qty.to_i,
      :best_buy_price => best_buy_price.to_f,
      :best_sell_qty => best_sell_qty.to_i,
      :best_sell_price => best_sell_price.to_f,
      :last_traded_price => last_traded_price.to_f,
      :volume => volume.to_i,
      :net_change => net_change.to_f,
      :percent_change => percent_change.to_f,
      :open_price => open_price.to_f,
      :high_price => high_price.to_f,
      :low_price => low_price.to_f,
      :close_price => close_price.to_f
    }
    self
  end

  module ClassMethods
    def find(id)
      stock_quote_json = REDIS.get("stock_quote:#{id}")
      stock_quote_json ? StockQuote.new.from_json(stock_quote_json) : nil
    end
  end
  extend ClassMethods
end
