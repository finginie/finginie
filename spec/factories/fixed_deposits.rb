# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fixed_deposit, :parent => :security, :class => FixedDeposit do
    period 9
    rate_of_interest 5
    name "MyString"
  end
end
