class Transaction < ActiveRecord::Base
  belongs_to :net_position

  validates :date, :presence => true
  validate  :date_should_not_be_in_the_future
  validates :net_position_id, :presence => true, :unless => :net_position
  validates :quantity, :presence => true
  validates :price, :presence => true

  def profit #TODO: Move related specs from net_positions
    quantity < 0 ? quantity * (price - average_cost) : 0
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
end
