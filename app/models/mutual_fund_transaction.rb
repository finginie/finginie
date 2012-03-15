class MutualFundTransaction < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :mutual_fund

  accepts_nested_attributes_for :mutual_fund

  validates_presence_of :price, :quantity, :date
  validates_numericality_of :price, :quantity
  validate  :date_should_not_be_in_the_future, :sell_quantity_should_be_less_than_or_equal_to_quantity

  validates :mutual_fund_id, :presence => true, :unless => :mutual_fund

  scope :buys, where("quantity >= ?", 0)
  scope :sells, where("quantity < ?", 0)
  scope :before, lambda { |date| where('date < ?', date) }

  scope :for, lambda { |name| joins(:mutual_fund).where("securities.name = ?", name).order(:date) } do
    include MutualFundPosition
  end

  def profit_or_loss
    ( amount * ( price - MutualFundTransaction.for(mutual_fund.name).average_price(self) ) ) if quantity < 0
  end

  def value
    amount * price
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

  def mutual_fund
    super || build_mutual_fund
  end

private
  def set_quantity(amount, action)
    action ||= :buy
    amount ||= 1
    self.quantity = { :buy => 1, :sell => -1}[action.to_sym] * amount.to_i
  end

  def date_should_not_be_in_the_future
    errors.add(:date, "can't be in the future") if !date.blank? and date > Date.today
  end

  def sell_quantity_should_be_less_than_or_equal_to_quantity
    errors.add(:amount, "Your portfolio do not have sufficient number of mutual funds for this action") if action == :sell && portfolio.mutual_fund_transactions.for(mutual_fund.name).quantity < amount
  end
end
