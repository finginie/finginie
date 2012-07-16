
require 'spec_helper'

describe "home page" do
  context "#index" do
    before(:each) do
      create :'data_provider/bse_scrip', :id => "Sensex",    :last_traded_price => 10, :close_price => 9
      create :'data_provider/nse_scrip', :id => "NSE Index", :last_traded_price => 10, :close_price => 9
      create :'data_provider/nse_scrip', :id => "GOLDBEES",  :last_traded_price => 10, :close_price => 9
    end
    it "should have market indices" do
      visit root_path
      content = "Nifty 10.0 1.00 (11.11 %) Sensex 10.0 1.00 (11.11 %) Gold (10 gm) 100.0 10.00 (11.11 %)"
      content_selector("span[@data-role='market_indices']").should eq content
    end
  end
end
