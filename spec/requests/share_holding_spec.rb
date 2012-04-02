require 'spec_helper'

describe "ShareHolding", :mongoid do
  let(:stock) { create :stock }
  let (:scrip) { create :scrip, :id => stock.symbol, :last_traded_price => 24.22 }
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

  it "should have stock search in the stock share holding page" do
    scrip.save
    visit stock_path stock
    click_link "Ratios"
    page.should have_selector("#stock_search")
  end
end
