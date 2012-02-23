# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :scheme_master do
    sequence(:securitycode, Time.now.to_i) { |n| n }
    sequence(:scheme_name, Time.now.to_i) { |n| "scheme_#{n}" }
    sequence(:company_code, Time.now.to_i + 3 ) { |n| n }
    scheme_class_code "2063"
    scheme_type_description "Open Ended"
    scheme_class_description "Special Fund"
    launch_date "02/03/2001"
    scheme_plan_description "Growth"
    minimum_invement_amount "5000"
    size "296.38"
    entry_load nil
    exit_load nil
    redemption_ferq "Daily"
    sip "True"
    fund_manager_prefix "Mr."
    fund_manager_name "Chirag Setalvad"

    trait :with_mfnav_detail do
      after_create do |scheme_master|
        FactoryGirl.create :mfnav_detail, :security_code => scheme_master.securitycode
      end
    end
    factory :scheme_master_with_mfnav_detail, :traits => [:with_mfnav_detail]
  end
end
