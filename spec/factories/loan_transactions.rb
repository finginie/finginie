# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :loan_transaction do
    portfolio
    loan
    price -10.99
    date "2012-03-02"
  end
end
