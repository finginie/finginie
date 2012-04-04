class MonthlySipCalculator
  include ActiveAttr::Model

  attribute :financial_goal,  :type => Float
  attribute :rate_of_return,  :type => Float
  attribute :no_months,       :type => Integer

  validates :financial_goal,  :presence => true,
                              :numericality => { :greater_than => 0 }
  validates :rate_of_return,  :presence => true,
                              :numericality => { :greater_than => 0 }
  validates :no_months,       :presence => true,
                              :numericality => { :greater_than => 0, :only_integer => true }

  def monthly_sip
    monthly_sip = ( financial_goal * monthly_rate_of_return )/( ( 1 + monthly_rate_of_return ) * ( ( ( 1 + monthly_rate_of_return ) ** no_months ) - 1 ) )
    monthly_sip > 0 ? monthly_sip.round(2) : 0
  end

  def monthly_rate_of_return
    rate_of_return/1200
  end
end
