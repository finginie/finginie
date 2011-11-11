class RecurringDepositCalculator
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :amount_deposit, :rate_of_return, :no_months, :interest_compound

  def self.float(attr, default_value)
    define_method(attr) do
      instance_variable_set "@#{attr}", instance_variable_get("@#{attr}") || default_value
    end

    define_method("#{attr}=") do |value|
      instance_variable_set "@#{attr}", value.to_f
    end
  end

   [:amount_deposit, :rate_of_return, :no_months
   ].each { |attr| float(attr, 0) }

  def initialize(attributes)
    attributes = {
      :amount_deposit => 0,
      :rate_of_return => 0,
      :no_months => 0,
      :interest_compound => 'Quarterly'

    }.merge ( attributes || {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def maturity_amount
    monthly_rate_of_return = (monthly_rate/100) +1
    maturity_amount =  ( amount_deposit * monthly_rate_of_return * ( ( monthly_rate_of_return ** no_months ) - 1) )/( monthly_rate_of_return -1)
    maturity_amount > 0 ? maturity_amount.round(2) : 0.0
  end

  def monthly_rate
    case interest_compound
      when "Monthly"
        rate_of_return / 12
      when "Quarterly"
        ((Math.exp((Math.log(1 + (rate_of_return / 400))) / 3)) - 1) *100
      when "HalfYearly"
        (Math.exp((Math.log(1 + (rate_of_return / 200))) / 6) -1 )*100
      when "Yearly"
        (Math.exp((Math.log(1 + (rate_of_return / 100))) / 12)-1) * 100
    end
  end
end
