class FixedIncome < Security
  belongs_to :user

  def current_value(transaction)
    transaction.price * Math.exp(Math.log( 1 + rate_of_interest/100) * (Date.today - transaction.date) / 365)
  end
end
