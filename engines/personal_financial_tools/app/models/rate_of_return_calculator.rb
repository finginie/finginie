class RateOfReturnCalculator
  include ActiveAttr::Model

  attribute :initial_investment,  :type => Float
  attribute :received_amount,     :type => Float
  attribute :no_years,            :type => Integer

  validates :initial_investment,  :presence => true,
                                  :numericality => { :greater_than => 0 }
  validates :received_amount,     :presence => true,
                                  :numericality => { :greater_than => 0 }
  validates :no_years,            :presence => true,
                                  :numericality => { :greater_than => 0, :only_integer => true }

  def calculate_rate_of_return
    (( ( ( received_amount/initial_investment ) ** ( 1/no_years.to_f ) ) - 1 ) * 100).round(2)
  end
end
