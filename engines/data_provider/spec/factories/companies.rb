# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company do
    sequence(:company_code, Time.now.to_i) { |n| n }
    sequence(:company_name, Time.now.to_i) { |n| "Company#{n}" }
    sequence(:nse_code, Time.now.to_i) { |n| "SYM#{n}" }
    industry_name "default_sector"

    trait :with_scrip do
      after_create do |company|
        FactoryGirl.create :scrip, :id => company.nse_code
      end
    end
    factory :company_with_scrip, :traits => [:with_scrip]
  end
end
