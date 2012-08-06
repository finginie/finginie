# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :completed_step do
    user_id 1
    step_id 1
    data ""
  end
end
