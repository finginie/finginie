# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mutual_fund_transaction do
        price "9.99"
        date "2012-03-05"
        quantity "10"
        #comments "MyText"
        portfolio
        mutual_fund
    end
end