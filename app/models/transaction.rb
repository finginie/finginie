class Transaction < ActiveRecord::Base
  belongs_to :net_position

  validates :date, :presence => true
  validate  :date_should_not_be_in_the_future
  validates :net_position_id, :presence => true, :unless => :net_position
  validates :quantity, :presence => true
  validates :price, :presence => true

  scope :statement, lambda {|portfolio_id| joins(:net_position).where('net_positions.portfolio_id = ?', portfolio_id).order('date') }

  def profit #TODO: Move related specs from net_positions
    quantity < 0 ? quantity * (price - average_cost) : 0
  end

  def current_value
    (quantity * net_position.security.current_value(self)).round
  end

  def maturity_value
    quantity * net_position.security.maturity_value(self).round
  end

  def action
    (quantity < 0 ? :sell : :buy) if quantity
  end
  def action=(action)
    set_quantity(amount, action)
    action
  end

  def amount
    quantity && quantity.abs
  end
  def amount=(amount)
    set_quantity(amount, action)
    amount
  end

  def total_value
    quantity * price
  end

private
  def average_cost
    previous_buy_transactions.sum("quantity * price").to_f / previous_buy_transactions.sum("quantity")
  end

  def previous_transactions
    net_position.transactions.where("date < ?", date)
  end

  def previous_buy_transactions
    previous_transactions.where("quantity > 0")
  end

  def date_should_not_be_in_the_future
    errors.add(:date, "can't be in the future") if !date.blank? and date > Date.today
  end

  def set_quantity(amount, action)
    action ||= :buy
    amount ||= 0
    self.quantity = { :buy => 1, :sell => -1}[action.to_sym] * amount.to_i
  end
end
