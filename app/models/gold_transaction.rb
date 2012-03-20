class GoldTransaction < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :gold

  validates_presence_of :price, :quantity, :date
  validates_numericality_of :price, :quantity
  validate  :date_should_not_be_in_the_future, :sell_quantity_should_be_less_than_or_equal_to_quantity

  scope :buys, where("action = ?", "buy")
  scope :sells, where("action = ?", "sell")
  scope :before, lambda { |date| where('date < ?', date) }

  def value
    amount * price
  end

  def amount
    action.to_sym == :buy ? quantity : (quantity * -1)
  end

  def profit_or_loss
    (quantity * ( price - portfolio.gold_transactions.average_price(self) ) ) if amount < 0
  end

private
  def date_should_not_be_in_the_future
    errors.add(:date, "can't be in the future") if !date.blank? and date > Date.today
  end

  def sell_quantity_should_be_less_than_or_equal_to_quantity
    errors.add(:quantity, "Your portfolio do not have sufficient number of stocks for this action") if action == "sell" && portfolio.gold_transactions.quantity <= quantity
  end

end
