class NiftyDecorator
  extend Module.new {
    delegate :last_traded_price, :net_change, :percent_change, :to => :nifty, :allow_nil => true

  private
    def nifty
      DataProvider::Nifty
    end
  }
end
