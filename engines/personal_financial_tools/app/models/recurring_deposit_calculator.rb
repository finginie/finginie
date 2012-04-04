class RecurringDepositCalculator
  include ActiveAttr::Model

  COMPOUNDING_FREQUENCY_OPTIONS = {
    'Monthly'    => 1,
    'Quarterly'  => 3,
    'HalfYearly' => 6,
    'Yearly'     => 12
    }

  attribute :amount_deposit,        :type => Float
  attribute :rate_of_return,        :type => Float
  attribute :no_months,             :type => Integer
  attribute :compounding_frequency, :type => Integer, :default => 3

  validates :amount_deposit,         :presence => true,
                                      :numericality => { :greater_than => 0 }
  validates :rate_of_return,          :presence => true,
                                      :numericality => { :greater_than => 0 }
  validates :no_months,               :presence => true,
                                      :numericality => { :greater_than => 0 }
  validates :compounding_frequency,   :presence => true,
                                      :inclusion => COMPOUNDING_FREQUENCY_OPTIONS.values

  def maturity_amount
    maturity_amount =  ( amount_deposit * monthly_rate_of_return * ( ( monthly_rate_of_return ** no_months ) - 1) )/( monthly_rate_of_return - 1)
    maturity_amount > 0 ? maturity_amount.round(2) : 0.0
  end

  def monthly_rate_of_return
    Math.exp((Math.log(1 + (rate_of_return * compounding_frequency / 1200.0))) / compounding_frequency.to_f)
  end
end
