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

  def repay(transaction)
    LoanTransaction.new(:portfolio_id => transaction.portfolio_id, :loan_id => transaction.loan_id).update_attributes(:price => transaction.current_value.abs, :date => Date.today, :action => "repay")
  end
end
