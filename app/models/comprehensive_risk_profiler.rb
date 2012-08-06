class ComprehensiveRiskProfiler < ActiveRecord::Base
  include CurrencyFormatter

  attr_accessible :age, :dependent, :household_expenditure, :household_income, :household_savings,
                  :portfolio_investment, :preference, :special_goals_amount, :special_goals_years,
                  :tax_saving_investment, :time_horizon, :score_cache

  belongs_to :user
  has_one :ideal_investment_mix

  PREFERENCE_OPTIONS = [1,4,6,8,10]
  PORTFOLIO_INVESTMENT_OPTIONS = [1, 5, 8, 10]
  MONTHLY_RATE_OF_RETURN = 0.006667
  DEFAULT_SCORE = 6

  WEIGHTAGE = { :AGE_WEIGHTAGE => 20, :HOUSEHOLD_EXPENDITURE_WEIGHTAGE => 0, :HOUSEHOLD_SAVINGS_WEIGHTAGE => 20, :HOUSEHOLD_INCOME_WEIGHTAGE => 10,
                :DEPENDENT_WEIGHTAGE => 5, :TIME_HORIZON_WEIGHTAGE => 10, :SPECIAL_GOAL_WEIGHTAGE => 10, :TAX_SAVING_INVESTMENT_WEIGHTAGE  => 0,
                :PREFERENCE_WEIGHTAGE => 10, :PORTFOLIO_INVESTMENT_WEIGHTAGE => 10 }

  validates :age,                   :numericality => {:greater_than => 0, :less_than_or_equal_to => 100}, :presence => true
  validates :household_expenditure, :numericality => {:greater_than_or_equal_to => 0}, :presence => true
  validates :household_income,      :numericality => {:greater_than_or_equal_to => 0}, :presence => true
  validates :household_savings,     :numericality => {:greater_than_or_equal_to => 0}, :presence => true
  validates :time_horizon,          :numericality => {:greater_than_or_equal_to => 0}, :presence => true
  validates :dependent,             :numericality => {:greater_than_or_equal_to => 0}, :presence => true
  validates :tax_saving_investment, :numericality => {:greater_than_or_equal_to => 0}, :allow_nil => true
  validates :special_goals_years,   :numericality => {:greater_than => 0}, :allow_nil => true
  validates :special_goals_amount,  :numericality => {:greater_than_or_equal_to => 0}, :allow_nil => true
  validates :preference,           :inclusion => { :in => PREFERENCE_OPTIONS },           :presence => true
  validates :portfolio_investment, :inclusion => { :in => PORTFOLIO_INVESTMENT_OPTIONS }, :presence => true

  attr_accessor :investment_check, :special_goals

  monetize :household_income, :household_savings, :household_expenditure, :tax_saving_investment, :special_goals_amount, :initial_investment

  before_save { score(true) }

  def score(recalculate = false)
    if recalculate && self.valid?
      self.score_cache = total_score
    else
      self.score_cache ||= total_score
    end
  end

  def special_goals_factor
    return 0 unless special_goals?
    no_of_month = special_goals_years * 12
    amount_required = special_goals_amount - (household_savings * (1.08 ** special_goals_years))
    (amount_required * MONTHLY_RATE_OF_RETURN)/( (1 + MONTHLY_RATE_OF_RETURN) * ( (1 + MONTHLY_RATE_OF_RETURN) ** no_of_month - 1 ))
  end

  def monthly_savings
    household_income - household_expenditure
  end

  def special_goals?
    special_goals_amount? && special_goals_years?
  end

  def available_savings
    household_savings - two_month_household_expenditure
  end

  def two_month_household_expenditure
    household_expenditure * 2
  end

  def initial_investment
    return IndianCurrency.new 0 unless self.valid?
    available_savings > 0 ? available_savings : household_savings / 2
  end

  def ideal_investment_mix
    @ideal_investment_mix ||= IdealInvestmentMix.new(self)
  end

private
  def age_score
    return 0 unless age
    age_value = (10 - (age - 20)/8)
    ([[age_value,10].min,1].max).round(2)
  end

  def household_savings_score
    return 0 if household_expenditure.nil?  || household_savings.nil?
    saving_value = ((household_savings/household_expenditure) * 1.67)
    [saving_value,10].min
  end

  def household_income_score
    return 0 if household_expenditure.nil? || household_income.nil?
    saving_value = ((household_income * 5)/household_expenditure)
    [saving_value,10].min
  end

  def dependent_score
    self.dependent = 0 unless dependent
    dependent_value = (10 - (2 * dependent))
    [[dependent_value, 10].min,1].max
  end

  def time_horizon_score
    self.time_horizon = 0 unless time_horizon
    [2 + (2 * time_horizon),10].min
  end

  def special_goal_score
    return 0 unless special_goals?
    special_goal_value = ((household_savings + ((monthly_savings * special_goals_years * 12) - special_goals_amount)) * 5)/ special_goals_amount
    special_goal_value += 5
    [[special_goal_value,10].min,0].max
  end

  def weighted_score
    [:special_goal_score, :portfolio_investment, :tax_saving_investment,
      :age_score, :preference, :dependent_score, :time_horizon_score,
      :household_savings_score, :household_expenditure, :household_income_score].collect {|attribute| weighted(attribute)}.inject(:+)
  end

  def weighted(attribute)
    return 0 unless self.send(attribute)
    weightage_attribute = attribute.to_s.gsub(/_score/,'').concat('_weightage').upcase.to_sym
    self.send(attribute).to_f * WEIGHTAGE[weightage_attribute]
  end

  def total_score
    score_value = (weighted_score / WEIGHTAGE.values.inject(:+)).round(2)
    [score_value, age_score].min
  end
end
