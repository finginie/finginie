# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
    user
    #subscribable

    factory :user_subscription do
      association :subscribable, :factory => :user_with_profile
    end
  end
end
