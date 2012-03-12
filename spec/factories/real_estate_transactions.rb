# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :real_estate_transaction do
      portfolio
      real_estate
      price 9.99
      date "2012-03-02"
  end
end
