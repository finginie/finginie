class NetPosition < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :security
  has_many :transactions, :before_add => :set_net_position

  validates :security_id, :presence => true, :unless => :security
  validates :portfolio_id, :presence => true

  accepts_nested_attributes_for :transactions,
                                :reject_if => lambda { |a| a[:price].blank? && a[:quantity].blank? },
                                :allow_destroy => true
  accepts_nested_attributes_for :security

  def quantity
    transactions.sum(:quantity)
  end

  def current_market_value
    quantity * security.current_price
  end

  def set_net_position(transaction)
    transaction.net_position ||= self
  end
end
