# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :net_asset_value_category do
    one_day_return "0.0227"
    one_week_return "0.1384"
    two_weeks_return "0.303"
    one_month_return "0.7133"
    three_months_return "2.2039"
    six_months_return "3.9196"
    nine_months_return "5.9551"
    one_year_return "7.9739"
    two_year_return "13.0577"
    three_year_return "15.9991"
  end
end
