class Loan < Security
  belongs_to :user

  def current_value(transaction)
    time_period = (Date.today.year - transaction.date.year) * 12 + (Date.today.month - transaction.date.month) + 1
    emi = EmiCalculator.new(:cost => transaction.price, :rate => rate_of_interest, :term => period).calculate_emi
    i = ( 1 + rate_of_interest / 1200)

    transaction.price * i ** time_period - emi.round * ( i ** time_period - 1) / (i - 1)
  end
end
