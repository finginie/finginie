# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company_master do
    sequence(:company_code, Time.now.to_i) { |n| n }
    sequence(:company_name, Time.now.to_i) { |n| "Company#{n}" }
  end
end
