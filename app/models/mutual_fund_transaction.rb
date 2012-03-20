class MutualFundTransaction < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :mutual_fund

  accepts_nested_attributes_for :mutual_fund

  validates_presence_of :date, :action
  validate  :date_should_not_be_in_the_future, :sell_quantity_should_be_less_than_or_equal_to_quantity
  validates :price, :numericality => {:greater_than => 0}, :presence => true
  validates :quantity, :numericality => {:greater_than => 0}, :presence => true

  validates :mutual_fund_id, :presence => true, :unless => :mutual_fund

  scope :buys, where("action = ?", "buy")
  scope :sells, where("action = ?", "sell")
  scope :before, lambda { |date| where('date < ?', date) }

  scope :for, lambda { |name| joins(:mutual_fund).where("securities.name = ?", name).order(:date) } do
    include MutualFundPosition
  end

  def profit_or_loss
    ( quantity * ( price - MutualFundTransaction.for(mutual_fund.name).average_price(self) ) ) if amount < 0
  end

  def value
    amount * price
  end

  def amount
    action.to_sym == :buy ? quantity : (quantity * -1)
  end

  def mutual_fund
    super || build_mutual_fund
  end

private
  def date_should_not_be_in_the_future
    errors.add(:date, "can't be in the future") if !date.blank? and date > Date.today
  end

  def sell_quantity_should_be_less_than_or_equal_to_quantity
    errors.add(:quantity, "Your portfolio do not have sufficient number of mutual funds for this action") if action == "sell" && portfolio.mutual_fund_transactions.for(mutual_fund.name).quantity < quantity
  end
end
