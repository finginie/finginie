# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fixed_deposit_transaction do
      portfolio
      fixed_deposit
      price 9.99
      action "buy"
      date "2012-03-02"
      comments ""
    end
end
