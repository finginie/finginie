# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stock_transaction do
      portfolio
      quantity 1
      price 9.99
      action "buy"
      date "2012-03-02"
      comments ""
      company_code { FactoryGirl.create(:company).code }
        #portfolio
        #stock
    end
end
