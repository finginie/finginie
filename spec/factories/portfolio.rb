# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :portfolio do
    sequence(:name, Time.now.to_i) { |n| "portfolio #{n}" }
    user
  end
end
