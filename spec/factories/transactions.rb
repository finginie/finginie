# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    net_position
    price "9.99"
    date "2011-09-08"
    quantity 1
    #comments "MyText"
  end
end
