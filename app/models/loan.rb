class Loan < Security
  include CurrencyFormatter
  attr_accessible :period, :rate_of_interest
  belongs_to :user

  validates :period, :numericality => {:greater_than => 0}, :presence => true
  validates :rate_of_interest,  :presence => true,
                                :numericality => {
                                  :greater_than => 0,
                                  :less_than => 37
                                }

  has_many :loan_transactions, :dependent => :destroy

#  def current_value(transaction)
#    time_period = (Date.today.year - transaction.date.year) * 12 + (Date.today.month - transaction.date.month) + 1
#    emi = EmiCalculator.new(:cost => transaction.price, :rate => rate_of_interest, :term => period).calculate_emi
#    i = ( 1 + rate_of_interest / 1200)
#
#    - (transaction.price * i ** time_period - emi * ( i ** time_period - 1) / (i - 1))
#  end

  def repay(transaction)
    LoanTransaction.new(:portfolio_id => transaction.portfolio_id, :loan_id => transaction.loan_id).update_attributes(:price => transaction.current_value.abs, :date => Date.today, :action => "repay")
  end
end
