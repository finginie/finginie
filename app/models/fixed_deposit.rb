class FixedDeposit < Security
  attr_accessible :period, :rate_of_interest
  belongs_to :user

  validates :period, :numericality => {:greater_than => 0}, :presence => true
  validates :rate_of_interest, :numericality => {:greater_than => 0}, :presence => true

  def current_value(transaction)
    value_at_date(transaction.price, [(Date.today - transaction.date) / 365, period].min)
  end

  def maturity_value(transaction)
    value_at_date(transaction.price, period)
  end

private
  def value_at_date(principal, period)
    principal * Math.exp(Math.log( 1 + rate_of_interest/100) * period)
  end
end
