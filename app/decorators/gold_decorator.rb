class GoldDecorator
  extend Module.new {

    def last_traded_price
      DataProvider::Gold.last_traded_price * 10 if DataProvider::Gold && DataProvider::Gold.last_traded_price
    end

    def net_change
      DataProvider::Gold.net_change * 10 if DataProvider::Gold && DataProvider::Gold.net_change
    end

    def percent_change
      DataProvider::Gold.percent_change if DataProvider::Gold
    end

    def name
      'Gold (10 gm)'
    end
  }
end
