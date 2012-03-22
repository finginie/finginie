class FixedDeposit < Security
  attr_accessible :period, :rate_of_interest, :rate_of_redemption
  belongs_to :user
  has_many :fixed_deposit_transactions

  validates :period, :numericality => {:greater_than => 0}, :presence => true
  validates :rate_of_interest,  :presence => true,
                                :numericality => {
                                  :greater_than => 0,
                                  :less_than => 37
                                }

  def current_value(transaction)
    value_at_date(transaction.price, [(Date.today - transaction.date) / 365, period].min)
  end

  def maturity_value(transaction)
    value_at_date(transaction.price, period)
  end

private
  def value_at_date(principal, period, rate_of_interest = rate_of_interest)
    principal * Math.exp(Math.log( 1 + rate_of_interest/100) * period)
  end
end
