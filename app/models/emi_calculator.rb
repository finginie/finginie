class EmiCalculator
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :cost, :down_payment, :rate, :term

  def initialize(attributes)
    attributes = {
      :cost => 0,
      :down_payment => 0,
      :rate => 0,
      :term => 0
    }.merge ( attributes || {})
    attributes.each do |name, value|
      send("#{name}=", value.to_f)
    end
  end

  def persisted?
    false
  end

  def calculate_emi
    monthly_emi = (cost - down_payment) * ( (1 + rate/1200) ** (term * 12) ) * ( ( 1 + rate/1200 ) - 1) / ( ( 1 + rate/1200 ) ** ( term * 12 ) - 1 )
    monthly_emi > 0 ? monthly_emi.round(2) : 0.0
  end
end
