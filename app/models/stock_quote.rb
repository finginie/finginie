class StockQuote
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include ActiveModel::Serializers::JSON
  extend ActiveModel::Naming
  attr_accessor :id, :symbol, :company_name, :time, :best_buy_qty, :best_buy_price, :best_sell_qty, :best_sell_price, :last_traded_price, :volume, :net_change, :percent_change, :open_price, :high_price, :low_price, :close_price

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
    @persisted = false
  end

  def attributes=(hash)
    hash.each do |k, v|
      instance_variable_set("@#{k}", v)
    end
  end

  def attributes
    instance_values
  end unless method_defined?(:attributes)

  def self.from_quote (tp_code, symbol, series, company_name, time, best_buy_qty, best_buy_price, best_sell_qty, best_sell_price, last_traded_price, volume, net_change, percent_change, open_price, high_price, low_price, close_price)
    new({
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
    })
  end

  def persisted?
    @persisted
  end

  def save
    @persisted = (REDIS.set("stock_quote:#{@id}", to_json) == "OK") 
  end

  def to_json
    super(:except => [:persisted])
  end
end
