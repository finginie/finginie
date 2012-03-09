class RealEstate < Security
  attr_accessible :location
  belongs_to :user

  has_many :real_estate_transactions

  def current_value(transaction)
    current_price || transaction.price
  end
end
