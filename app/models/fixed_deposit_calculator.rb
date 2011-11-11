class FixedDepositCalculator
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :amount_invested, :rate_of_return, :no_months, :interest_compound

  def self.float(attr, default_value)
    define_method(attr) do
      instance_variable_set "@#{attr}", instance_variable_get("@#{attr}") || default_value
    end

    define_method("#{attr}=") do |value|
      instance_variable_set "@#{attr}", value.to_f
    end
  end

  [:amount_invested, :rate_of_return, :no_months
  ].each { |attr| float(attr, 0) }

  def initialize(attributes)
    attributes = {
      :amount_invested => 0,
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
    modulo_month =  no_months.modulo(months)
    floor_month =  (no_months/months).floor
    rate_of_return_monthly = (rate_of_return/(1200/months)) +1
    (amount_invested * ( rate_of_return_monthly ** floor_month ) * ( rate_of_return_monthly ) ** ( modulo_month/months )).round(2)
  end

  def months
    month =
    {
      "Monthly" => 1.0,
      "Quarterly" => 3.0,
      "HalfYearly" => 6.0,
      "Yearly" => 12.0
    }
    month.fetch(interest_compound)
  end
end
