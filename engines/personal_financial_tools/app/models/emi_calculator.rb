class EmiCalculator
  include ActiveAttr::Model

  attribute :cost,         :type => Float
  attribute :rate,         :type => Float
  attribute :term,         :type => Float
  attribute :down_payment, :type => Float, :default => 0

  validates :cost,          :presence => true,
                            :numericality => { :greater_than => 0 }
  validates :rate,          :presence => true,
                            :numericality => { :greater_than => 0 }
  validates :term,          :presence => true,
                            :numericality => { :greater_than => 0 }
  validates :down_payment,  :numericality => { :greater_than_or_equal_to => 0 }

  def calculate_emi
    monthly_emi = (cost - down_payment) * ( (1 + rate/1200) ** (term * 12) ) * ( ( 1 + rate/1200 ) - 1) / ( ( 1 + rate/1200 ) ** ( term * 12 ) - 1 )
    monthly_emi > 0 ? monthly_emi.round(2) : 0.0
  end
end
