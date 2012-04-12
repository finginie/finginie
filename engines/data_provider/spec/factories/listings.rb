# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :listing do
    sequence(:security_code, Time.now.to_f.to_s) { |n| n }
  end
end
