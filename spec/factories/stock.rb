# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stock, :parent => :security, :class => Stock do
    sequence(:name, Time.now.to_i) { |n| "Company #{n}" }
    sequence(:symbol, Time.now.to_i) { |n| "FOOBAR#{n}" }

    trait :with_scrip do
      after_create do |stock|
        FactoryGirl.create :scrip, :id => stock.symbol
      end
    end
    factory :stock_with_scrip, :traits => [:with_scrip]
  end
end
