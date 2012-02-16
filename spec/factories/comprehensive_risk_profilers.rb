# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comprehensive_risk_profiler do
      user
      age 1
      household_savings 1
      household_income 1
      dependent 3
      household_expenditure 1
      tax_saving_investment 100000
      special_goals_amount 2000000
      special_goals_years 5
      preference 6
      portfolio_investment 1
      time_horizon 4
    end
end
