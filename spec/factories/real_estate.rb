# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :real_estate, :parent => :security, :class => RealEstate do
    current_price 9.99
  end
end
