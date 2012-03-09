# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stock_transaction do
      portfolio
      stock
      quantity 1
      price 9.99
      date "2012-03-02"
        #portfolio
        #stock
    end
end
