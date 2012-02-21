# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :security do
    name "MyString"
    #user
    #current_price "9.99"
    #period "9.99"
    #rate_of_interest "9.99"
    #location "MyText"
    #emi "9.99"
    factory :real_estate, :class => RealEstate do
    end
    factory :fixed_income, :class => FixedIncome do
    end
    factory :loan, :class => Loan do
    end
    factory :mutual_fund, :class => MutualFund do
    end
  end
end
