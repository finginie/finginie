# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :net_position do
    portfolio
    security

    ignore do
      number_of_transaction 1
    end

    trait :with_transactions do
      after_create do |net_position, proxy|
        FactoryGirl.create_list :transaction, proxy.number_of_transaction, :net_position => net_position
      end
    end

    factory :net_position_with_transactions, :traits => [:with_transactions]
  end
end
