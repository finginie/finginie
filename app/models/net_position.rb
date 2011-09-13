class NetPosition < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :security
  has_many :transactions

  validates :security_id, :presence => true
  validates :portfolio_id, :presence => true

  def quantity
    transactions.sum(:quantity)
  end

  def current_market_value
    quantity * security.current_price
  end
end
