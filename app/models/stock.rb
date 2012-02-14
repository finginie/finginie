class Stock < Security
  attr_accessible :symbol, :sector, :beta, :eps, :pe, :fifty_two_week_high_price, :fifty_two_week_high_date, :fifty_two_week_low_price, :fifty_two_week_low_date
  scope :by_last_traded_price, lambda { |min, max| where(:symbol => Scrip.find_ids_by_last_traded_price(min, max)) }
  scope :by_percent_change, lambda { |min, max| where(:symbol => Scrip.find_ids_by_percent_change(min, max)) }

  validates :name, :uniqueness => true
  validates :symbol, :uniqueness => true

  SCRIP_METHODS = [:last_traded_price, :percent_change, :volume, :high_price, :low_price, :best_buy_price, :best_buy_quantity, :best_sell_price, :best_sell_quantity]
  delegate *SCRIP_METHODS, :to => :scrip, :allow_nil => true

  def scrip
    Scrip.find(symbol)
  end

  def current_value(transaction)
    last_traded_price
  end

  def as_json(options = {})
    options ||= {}
    super(options.merge(:methods => SCRIP_METHODS))
  end
end
