class MonthlySipCalculator
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :financial_goal, :rate_of_return, :no_months

  def initialize(attributes)
    attributes = {
      :financial_goal => 0,
      :rate_of_return => 0,
      :no_months => 0,

    }.merge ( attributes || {})
    attributes.each do |name, value|
      send("#{name}=", value.to_f)
    end
  end

  def persisted?
    false
  end

  def monthly_sip
    monthly_sip = ( financial_goal * rate_of_return_monthly )/( ( 1 + rate_of_return_monthly ) * ( ( ( 1 + rate_of_return_monthly ) ** no_months ) - 1 ) )
    monthly_sip > 0 ? monthly_sip.round(2) : 0
  end

  def rate_of_return_monthly
    rate_of_return/1200
  end
end
