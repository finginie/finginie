class RealEstate < Security
  attr_accessible :location
  belongs_to :user

  validates :current_price, :numericality => {:greater_than => 0}, :presence => true

  has_many :real_estate_transactions, :dependent => :destroy

  def current_value(transaction)
    current_price || transaction.price
  end
end
