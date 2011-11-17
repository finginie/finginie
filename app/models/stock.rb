class Stock < Security
  scope :by_last_traded_price, lambda { |min, max| where(:symbol => Scrip.find_ids_by_last_traded_price(min, max)) }
  scope :by_percent_change, lambda { |min, max| where(:symbol => Scrip.find_ids_by_percent_change(min, max)) }

  validates :name, :uniqueness => true
  validates :symbol, :uniqueness => true

  delegate :last_traded_price, :percent_change, :volume, :high_price, :low_price, :best_buy_price, :best_buy_quantity, :best_sell_price, :best_sell_quantity, :to => :scrip

  def scrip
    Scrip.find(symbol)
  end

  def current_value(transaction)
    last_traded_price
  end
end
