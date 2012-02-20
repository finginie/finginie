class NsePrice
  include Mongoid::Document
  extend MongoidHelpers

    field :security_code, :type => BigDecimal
    field :price_date, :type => Date
    field :open_price, :type => Float
    field :high_price, :type => Float
    field :low_price, :type => Float
    field :close_price, :type => Float
    field :trading_day_close_indicator
    field :traded_value, :type => Float
    field :traded_quantity, :type => Integer
    field :number_of_trades, :type => Integer
    field :modified_date, :type => DateTime

    key :security_code, :price_date
end
