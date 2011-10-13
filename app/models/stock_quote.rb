require 'active_model_object'

class StockQuote < Valuable
  include ActiveModelObject
  [
    :id, :best_buy_qty, :best_sell_qty, :volume
  ].each { |attr| has_value attr, :klass => :integer }
  [
    :best_buy_price, :best_sell_price, :last_traded_price, :net_change,
    :percent_change, :open_price, :high_price, :low_price, :close_price
  ].each { |attr| has_value attr, :klass => :decimal }
  has_value :symbol
  has_value :company_name
  has_value :time, :klass => DateTime
  has_value :persisted, :klass => :boolean, :default => false

  def save
    @persisted = (REDIS.set("stock_quote:#{id}", to_json) == "OK")
  end

  def time=(value)
    @time = value.is_a?(DateTime) ? value : DateTime.parse(value)
  end

  module ClassMethods
    def find(id)
      stock_quote_json = REDIS.get("stock_quote:#{id}")
      stock_quote_json ? StockQuote.new.from_json(stock_quote_json) : nil
    end
  end
  extend ClassMethods
end
