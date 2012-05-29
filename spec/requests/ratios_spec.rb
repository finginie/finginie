require 'spec_helper'

describe "Ratios", :mongoid do
  let(:company) { create :company, :major_sector => 2 }

  it "should show the banking ratios page for Stock" do
    @banking_ratio = create :banking_ratio, :company_code => company.code, :year_ending => '31/03/2011',
                                            :capital_adequacy_ratio => "13.64",
                                            :fund_based_income_as_a_per_of_op_income => "92.73",
                                            :borrowings_from_others_as_a_per_to_total_borrowings => "1.3",
                                            :borrowings_within_india_as_a_per_to_total_borrowings => "83.25",
                                            :deposits_outside_india_as_per_to_total_deposits => "0.22",
                                            :deposits_per_branch => "221.4549"

    visit stock_ratios_path(company.name)
    page.should have_content 'Capital Adequacy Ratio'
    page.should have_content 'EARNINGS RATIOS'
    page.should have_content 'Fund based income as a % of Op Income'
    page.should have_content "92.73"
    page.should have_content "83.25"
  end

  it "should show the ratios page for stock for non-banking" do

    company.update_attribute( :major_sector, 1)
    @ratio = create :ratio, :company_code => company.code, :year_ending => '31/03/2011',
                                            :sell_distribut_cost_comp => "24.23",
                                            :interest_coverage => "3.2306",
                                            :total_debtto_ownersfund => "9.6534",
                                            :investments_turn_ratio => "16.1172",
                                            :earning_retention_ratio => "100",
                                            :reported_cash_eps => "12.9583",
                                            :net_profit_margin => "9.19",
                                            :asset_turnover_ratio => "2.1852"

    visit stock_ratios_path(company.name)
    page.should have_content 'Capital Adequacy Ratio'
    page.should have_content 'COMPONENT RATIOS'
    page.should have_content @ratio.sell_distribut_cost_comp.round(2)
    page.should have_content @ratio.interest_coverage.round(2)
    page.should have_content @ratio.total_debtto_ownersfund.round(2)
    page.should have_content @ratio.investments_turn_ratio.round(2)
    page.should have_content @ratio.earning_retention_ratio.round(2)
    page.should have_content @ratio.reported_cash_eps.round(2)
    page.should have_content @ratio.net_profit_margin.round(2)
    page.should have_content @ratio.asset_turnover_ratio.round(2)
  end

  it "should have stock search in the stock ratio page" do
    visit stock_path company.name
    click_link "Ratios"
    page.should have_selector("#new_company")
  end

  it "show page shouldn't throw any error when company not exists" do
    visit stock_ratios_path 18
    page.status_code.should eq 200
  end

  it "should have a title" do
    visit stock_ratios_path( company.name)
    page.should have_selector("title", :content => I18n.t('ratios.title'))
  end
end
