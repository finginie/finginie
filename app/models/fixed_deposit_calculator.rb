class FixedDepositCalculator
  include ActiveAttr::Model

  COMPOUNDING_FREQUENCY_OPTIONS = {
    'Monthly'    => 1,
    'Quarterly'  => 3,
    'HalfYearly' => 6,
    'Yearly'     => 12
    }

  attribute :amount_invested,         :type => Float
  attribute :rate_of_return,          :type => Float
  attribute :no_months,               :type => Integer
  attribute :compounding_frequency,   :type => Integer, :default => 3

  validates :amount_invested,         :presence => true,
                                      :numericality => { :greater_than => 0 }
  validates :rate_of_return,          :presence => true,
                                      :numericality => { :greater_than => 0 }
  validates :no_months,               :presence => true,
                                      :numericality => { :greater_than => 0 }
  validates :compounding_frequency,   :presence => true,
                                      :inclusion => COMPOUNDING_FREQUENCY_OPTIONS.values

  def maturity_amount
    extra_months =  no_months%compounding_frequency
    compounding_peroid =  (no_months/compounding_frequency).floor
    rate_of_return_monthly = (rate_of_return/(1200/compounding_frequency)) +1
    (amount_invested * ( rate_of_return_monthly ** compounding_peroid ) * ( rate_of_return_monthly ) ** ( extra_months/compounding_frequency.to_f )).round(2)
  end
end
