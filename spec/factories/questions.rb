# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    ignore do
      number_of_choices 0
    end

    #weight "9.99"
    text "Are you a good boy?"
    #quiz

    after_create do |question, proxy|
      FactoryGirl.create_list :choice, proxy.number_of_choices, :question => question
    end
  end
end
