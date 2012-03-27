class RetirementCorpusCalculator
  include ActiveAttr::Model

  attribute :current_age,      :type => Integer
  attribute :retirement_age,   :type => Integer
  attribute :monthly_expenses, :type => Float
  attribute :inflation,        :type => Float
  attribute :expected_return,  :type => Float

  validates :current_age,       :presence => true,
                                :numericality => { :greater_than => 0, :only_integer =>true }
  validates :retirement_age,    :presence => true,
                                :numericality => { :greater_than => 0, :only_integer =>true }
  validates :monthly_expenses,  :presence => true,
                                :numericality => { :greater_than => 0 }
  validates :inflation,         :presence => true,
                                :numericality => { :greater_than => 0 }
  validates :expected_return,   :presence => true,
                                :numericality => { :greater_than => 0 }

  AGE_OF_DEATH = 80

  def retirement_corpus
    retirement_year_expenses * (appreciation_factor ** retirement_life_span - 1) / (appreciation_factor - 1)
  end

  def monthly_savings
    MonthlySipCalculator.new(:financial_goal => retirement_corpus, :rate_of_return => expected_return, :no_months => months_to_retirement).monthly_sip
  end

  def retirement_year_expenses
     monthly_expenses * 12 * (inflation_factor ** (retirement_age - current_age))
  end

  def months_to_retirement
    (retirement_age - current_age) * 12
  end

  def retirement_life_span
    AGE_OF_DEATH - retirement_age
  end

  def inflation_factor
    1 + inflation / 100
  end

  def expected_return_factor
    1 + expected_return / 100
  end

  def appreciation_factor
    inflation_factor / expected_return_factor
  end

end
