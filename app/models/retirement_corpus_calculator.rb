class RetirementCorpusCalculator
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :current_age, :retirement_age, :monthly_expence, :inflation, :expected_return

  def initialize(attributes)
    attributes = {
      :current_age => 0,
      :retirement_age => 0,
      :monthly_expence => 0,
      :inflation => 0,
      :expected_return => 0

    }.merge ( attributes || {})
    attributes.each do |name, value|
      send("#{name}=", value.to_f)
    end
  end

  def persisted?
    false
  end
  AGE_OF_DEATH = 80

  def monthly_return
   	retirement_corpus = 0.0

    for i in 1..retirement_life_span
      retirement_corpus += (( 1 + (inflation/100) ) ** i ) * retirement_year_expenses / (( 1+ (expected_return/100) ) ** i )
    end

    monthly_return = ( retirement_corpus * (rate_of_return - 1) )/ ( rate_of_return * ( ( rate_of_return ** months_to_retirement )-1))
    monthly_return > 0 ? monthly_return.round(2) : 0 
  end

  def retirement_year_expenses
     monthly_expence * 12 * (((1 + (inflation / 100))**(retirement_age - current_age)))
  end

  def months_to_retirement
    (retirement_age - current_age) * 12
  end

  def rate_of_return
    ((((Math.exp((Math.log(1 + expected_return / 100)) / 12)) - 1) *100)/100)+1
  end

  def retirement_life_span
    (AGE_OF_DEATH - retirement_age).ceil
  end

end
