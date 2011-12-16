class SipCalculator
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :initial_investment, :monthly_amount, :no_months, :rate_of_return

  def initialize(attributes)
    attributes = {
      :initial_investment => 0,
      :monthly_amount => 0,
      :no_months => 0,
      :rate_of_return => 0
    }.merge ( attributes || {})
    attributes.each do |name, value|
      send("#{name}=", value.to_f)
    end
  end

  def persisted?
    false
  end

  def calculate_sip
    rate_of_return_monthly = (rate_of_return/1200) +1
    final_amount = [(monthly_amount * rate_of_return_monthly * (( rate_of_return_monthly ** (no_months) ) -1 )) / (rate_of_return_monthly -1) ,
                    (rate_of_return_monthly**no_months)*initial_investment].sum
    final_amount > 0 ? final_amount.round(2) : 0
  end

end
