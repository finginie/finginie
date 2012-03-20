class GoldTransaction < ActiveRecord::Base
  belongs_to :portfolio

  validates_presence_of :date, :action
  validate  :date_should_not_be_in_the_future, :sell_quantity_should_be_less_than_or_equal_to_quantity
  validates :price, :numericality => {:greater_than => 0}, :presence => true
  validates :quantity, :numericality => {:greater_than => 0}, :presence => true

  scope :for, lambda { |gold| order('date, created_at') } do
    include GoldPosition
  end

  def gold
    Gold
  end
  alias :security :gold

  include MarketTradableTransaction

private
  def sell_quantity_should_be_less_than_or_equal_to_quantity
    errors.add(:amount, "Your portfolio do not have sufficient gold for this action") if action == :sell && portfolio.gold_transactions.for(Gold).quantity <= amount
  end
end
