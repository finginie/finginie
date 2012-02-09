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

  end

  it "should show the banking ratios page for Stock" do
    visit stock_ratios_path(:stock_id => stock.id)
    page.should have_content 'Capital Adequacy Ratio'
    page.should have_content 'EARNINGS RATIOS'
    page.should have_content 'Fund based income as a % of Op Income'
    page.should have_content "92.73"
    page.should have_content "83.25"
  end

end
