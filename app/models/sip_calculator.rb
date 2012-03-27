class SipCalculator
  include ActiveAttr::Model

  attribute :initial_investment, :type => Float, :default => 0
  attribute :monthly_amount,     :type => Float
  attribute :no_months,          :type => Integer
  attribute :rate_of_return,     :type => Float

  validates :initial_investment,  :numericality => { :greater_than => 0 }
  validates :monthly_amount,      :presence => true,
                                  :numericality => { :greater_than => 0 }
  validates :rate_of_return,      :presence => true,
                                  :numericality => { :greater_than => 0 }
  validates :no_months,           :presence => true,
                                  :numericality => { :greater_than => 0, :only_integer => true }

  def calculate_sip
    rate_of_return_monthly = (rate_of_return/1200) +1
    final_amount = [(monthly_amount * rate_of_return_monthly * (( rate_of_return_monthly ** (no_months) ) -1 )) / (rate_of_return_monthly -1) ,
                    (rate_of_return_monthly**no_months)*initial_investment].sum
    final_amount > 0 ? final_amount.round(2) : 0
  end

end
