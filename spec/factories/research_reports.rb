# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :research_report do
    date "2012-08-13"
    source "MyString"
    name "MyString"
    company_name "MyString"
    sector "MyString"
    nse_code "MyString"
    bse_code "MyString"
    link_url "MyString"
    recommendation "MyString"
    current_market_price "9.99"
    target_price "9.99"
  end
end
