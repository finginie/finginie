class RealEstate < Security
  attr_accessible :location
  belongs_to :user

  def current_value(transaction)
    current_price || transaction.price
  end
end
