FactoryGirl.define do
  factory :user do
    sequence(:email, Time.now.to_i) {|n| "person#{n}@example.com" }
    password "password"

    # factory :admin do
    #   role "admin"
    # end
  end
end

