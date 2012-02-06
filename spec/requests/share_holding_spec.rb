require 'spec_helper'

describe "ShareHolding", :mongoid do
  let(:stock) { create :stock }
  before :each do
    @company = create :company_master, :nse_code => stock.symbol
    @share_holding = create :share_holding, :company_code => @company.company_code
  end

  it "should show the share holding pattern for a Stock" do
    visit stock_share_holding_path(:stock_id => stock.id )
    page.should have_content 'Foreign Institional Investors (FIIs)'
    page.should have_content '8.52'
    page.should have_content 'Other Foreign Investors'
    page.should have_content '0.24'
    page.should have_content 'Others'
    page.should have_content '3.27'
    page.should have_content '0.43'
  end
end
