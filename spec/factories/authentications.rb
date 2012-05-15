# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authentication do
    user
    provider "finginie"
    uid "12345"
  end
end
