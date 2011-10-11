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
    transactions.sum :quantity
  end

  def buy_quantity
    buy_transactions.sum(:quantity)
  end

  def sale_quantity
    - sell_transactions.sum(:quantity)
  end

  def total_cost
    buy_transactions.sum("quantity * price")
  end

  def total_sale
    - sell_transactions.sum("quantity * price").to_f
  end

  def current_value
    quantity * security.current_price
  end

  def average_cost
    total_cost / buy_quantity
  end

  def unrealised_profit
    quantity * ( security.current_price - average_cost )
  end

  def profit
    total_sale - sale_quantity * average_cost
  end

private
  def set_net_position(transaction)
    transaction.net_position ||= self
  end

  def buy_transactions
    transactions.where("quantity > 0")
  end

  def sell_transactions
    transactions.where("quantity < 0")
  end
end
