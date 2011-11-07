class Stock < Security
  scope :by_last_traded_price, lambda { |min, max| where(:id => Scrip.find_ids_by_last_traded_price(min, max))  }
  scope :by_percent_change, lambda { |min, max| where(:id => Scrip.find_ids_by_percent_change(min, max))  }
  validates :name, :uniqueness => true
end
