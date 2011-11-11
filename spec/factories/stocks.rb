# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stock, :parent => :security, :class => Stock do
    sequence(:name, Time.now.to_i) { |n| "Company #{n}" }
  end
end
