# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mutual_fund, :parent => :security, :class => MutualFund do
    sequence(:name, Time.now.to_i) { |n| "Scheme #{n}" }

    trait :with_scheme_master do
      after_create do |mutual_fund|
        FactoryGirl.create :scheme_master_with_navcp, :scheme_name => mutual_fund.name
      end
    end
    factory :mutual_fund_with_scheme_master, :traits => [:with_scheme_master]
  end
end
