# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :quiz do
    ignore do
      number_of_questions 0
      number_of_choices_per_question 0
    end

    #type ""
    name "MyString"
    #weight "9.99"
    result_type "mean"

    after(:create) do |quiz, proxy|
      FactoryGirl.create_list :question, proxy.number_of_questions, :quiz => quiz, :number_of_choices => proxy.number_of_choices_per_question
    end
  end
end
