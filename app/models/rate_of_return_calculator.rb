class RateOfReturnCalculator
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :initial_investment, :received_amount, :no_years

  def initialize(attributes)
    attributes = {
      :initial_investment => 0,
      :received_amount => 0,
      :no_years => 0,

    }.merge ( attributes || {})
    attributes.each do |name, value|
      send("#{name}=", value.to_f)
    end
  end

  def persisted?
    false
  end

  def calculate_rate_of_return
    rate_of_return = ( ( ( received_amount/initial_investment ) ** ( 1/no_years ) ) -1 ) * 100
    rate_of_return > 0 ? rate_of_return.round(2) : 0
  end
end

