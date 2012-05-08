class GoldDecorator
  extend Module.new {
    delegate :percent_change, :to => Gold, :allow_nil => true

    def current_price
      Gold.current_price * 10 if Gold.current_price
    end

    def net_change
      Gold.net_change * 10 if Gold.net_change
    end
  }
end
