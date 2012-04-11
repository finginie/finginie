# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :scheme do
    sequence(:securitycode, Time.now.to_i) { |n| n }
    sequence(:scheme_name, Time.now.to_i) { |n| "scheme_#{n}" }
    sequence(:company_code, Time.now.to_i + 3 ) { |n| n }
    scheme_class_code "2063"
    scheme_type_description "Open Ended"
    scheme_class_description "Special Fund"
    launch_date "02/03/2001"
    scheme_plan_description "Growth"
    minimum_investment_amount "5000"
    size "296.38"
    entry_load nil
    exit_load nil
    redemption_frequency "Daily"
    sip "True"
    fund_manager_prefix "Mr."
    fund_manager_name "Chirag Setalvad"

   end
end
