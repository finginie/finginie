require 'spec_helper'

describe "MutualFundCategories", :mongoid do
  let (:navcd) { create :net_asset_value_category, :scheme_class_description => "Special Fund", :scheme_class_code => 1 }
  let (:scheme) { create :scheme, :class_description => navcd.scheme_class_description, :rank => 10, :nav_amount => 10,
                                  :minimum_investment_amount => 20, :class_code => navcd.scheme_class_code,
                                  :prev1_week_percent => 1, :prev1_month_percent => 2, :prev3_months_percent => 2,
                                  :prev6_months_percent => 3, :prev_year_percent => 3, :prev2_year_comp_percent => 2,
                                  :prev3_year_comp_percent => 3
                }

  it "should scheme categories show page" do
    navcd.save
    scheme.save

    visit mutual_funds_path
    click_link scheme.class_description

    expected_table = [
                         [ scheme.name, "10", "10.00", "20.00", "1.00", "2.00", "2.00", "3.00", "3.00", "2.00", "3.00"]
                      ]

    page.should have_content scheme.class_description
    page.should have_content scheme.name
    tableish("table").should include *expected_table
  end
end
