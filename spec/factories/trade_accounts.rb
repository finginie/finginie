# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trade_account do
    user nil
    name "MyString"
    phone_number "MyString"
    address "MyText"
    city "MyString"
    special_requirements "MyText"
  end
end
