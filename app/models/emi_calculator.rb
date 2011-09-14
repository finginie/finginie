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

  def emi
    i = 1 + rate/1200
    n = term * 12
    ((cost - down_payment) * ( i ** n ) * (i - 1) / ( i ** n - 1 )).round
  end
end
