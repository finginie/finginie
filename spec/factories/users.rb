FactoryGirl.define do
  factory :user do
    sequence(:email, Time.now.to_i) {|n| "person#{n}@example.com" }
    password "password"

    # factory :admin do
    #   role "admin"
    # end

    trait :with_profile do
      name 'Smith'
      location '01'
      occupation 'Agent'
      company 'Matrix'
    end

    factory :user_with_profile, :traits => [:with_profile]
  end
end

