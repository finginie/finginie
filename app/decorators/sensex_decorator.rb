class SensexDecorator
  extend Module.new {
    delegate :last_traded_price, :net_change, :percent_change, :to => :sensex, :allow_nil => true

  private
    def sensex
      DataProvider::Sensex
    end
  }
end
