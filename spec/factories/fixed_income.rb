# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fixed_income, :parent => :security, :class => FixedIncome do
    period 9
    rate_of_interest 5
  end
end
