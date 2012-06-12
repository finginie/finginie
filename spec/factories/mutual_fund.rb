# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mutual_fund, :parent => :security, :class => MutualFund do
    sequence(:name, Time.now.to_i) { |n| "Scheme #{n}" }

    trait :with_scheme_master do
      after(:create) do |mutual_fund|
        FactoryGirl.create :'data_provider/scheme', :scheme_name => mutual_fund.name, :nav_amount => 5
      end
    end
    factory :mutual_fund_with_scheme_master, :traits => [:with_scheme_master]
  end
end
