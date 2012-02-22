# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :loan, :parent => :security, :class => Loan do
    period 9
    rate_of_interest 5
  end
end
