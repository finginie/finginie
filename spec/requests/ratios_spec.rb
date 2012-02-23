require 'spec_helper'

describe "Ratios", :mongoid do
  let(:stock) { create :stock }
  before :each do
    @company = create :company_master, :nse_code => stock.symbol, :major_sector => 2
    @banking_ratio = create :banking_ratio, :company_code => @company.company_code, :year_ending => '31/03/2011',
                                            :capital_adequacy_ratio => "13.64",
                                            :fund_based_income_as_a_per_of_op_income => "92.73",
                                            :borrowings_from_others_as_a_per_to_total_borrowings => "1.3",
                                            :borrowings_within_india_as_a_per_to_total_borrowings => "83.25",
                                            :deposits_outside_india_as_per_to_total_deposits => "0.22",
                                            :deposits_per_branch => "221.4549"
    @ratio = create :ratio, :company_code => @company.company_code, :year_ending => '31/03/2011',
                                            :sell_distribut_cost_comp => "24.23",
                                            :interest_coverage => "3.2306",
                                            :total_debtto_ownersfund => "9.6534",
                                            :investments_turn_ratio => "16.1172",
                                            :earning_retention_ratio => "100",
                                            :reported_cash_eps => "12.9583",
                                            :net_profit_margin => "9.19",
                                            :asset_turnover_ratio => "2.1852"

  end

  it "should show the banking ratios page for Stock" do
    visit stock_ratios_path(:stock_id => stock.id)
    page.should have_content 'Capital Adequacy Ratio'
    page.should have_content 'EARNINGS RATIOS'
    page.should have_content 'Fund based income as a % of Op Income'
    page.should have_content "92.73"
    page.should have_content "83.25"
  end

  it "should show the ratios page for stock for non-banking" do
    @company.update_attribute( :major_sector, 1)
    visit stock_ratios_path(:stock_id => stock.id)
    page.should have_content 'Capital Adequacy Ratio'
    page.should have_content 'COMPONENT RATIOS'
    page.should have_content @ratio.sell_distribut_cost_comp
    page.should have_content @ratio.interest_coverage
    page.should have_content @ratio.total_debtto_ownersfund
    page.should have_content @ratio.investments_turn_ratio
    page.should have_content @ratio.earning_retention_ratio
    page.should have_content @ratio.reported_cash_eps
    page.should have_content @ratio.net_profit_margin
    page.should have_content @ratio.asset_turnover_ratio
  end
end