# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gold_transaction do
    price "9.99"
    date "2012-03-06"
    quantity 1
    #comments "MyText"
    portfolio
    gold
  end
end