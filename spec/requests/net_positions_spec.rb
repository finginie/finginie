require 'spec_helper'

describe "NetPositions" do
  describe "Add new net position" do
    let (:portfolio) { create :portfolio }
    let (:stock) { create :stock }
    it "adds new stock position" do #, :driver => :selenium do
      stock
      visit new_portfolio_net_position_path(portfolio, :security_type => "Stock")
      select stock.name, :from => "Security"
      fill_in "Price", :with => 200
      #fill_in "Date", :with => "29-11-2010"
      fill_in "Quantity", :with => 30
      click_on "Create Net position"
      page.should have_content stock.name
      page.should have_content 200
      page.should have_content 30
    end
  end
end
