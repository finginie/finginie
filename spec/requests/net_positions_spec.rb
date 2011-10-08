require 'spec_helper'

describe "NetPositions" do
  describe "Add new net position", :js => true do
    let (:portfolio) { create :portfolio }
    let (:stock) { create :stock }

    before :each do
      visit portfolio_path(portfolio)
    end

    it "adds new stock position" do
      stock # ensure stock is created
      click_on 'Add New Stock'
      select stock.name, :from => "Security"

      fill_in "Price", :with => 200
      #fill_in "Date", :with => "29-11-2010"
      fill_in "Quantity", :with => 30
      click_on "Create Net position"

      page.should have_content stock.name
      page.should have_content 200
      page.should have_content 30
    end

    it "adds new fixed income position" do
      click_on 'Add New Fixed income'
      fill_in 'Name', :with => 'Test Income'
      fill_in 'Period', :with => 20
      fill_in 'Rate of interest', :with => 12

      fill_in "Price", :with => 200
      #fill_in "Date", :with => "29-11-2010"
      fill_in "Quantity", :with => 30
      click_on "Create Net position"

      page.should have_content 'Test Income'
      page.should have_content 200
      page.should have_content 30
    end

    it "adds new loan position" do
      click_on 'Add New Loan'
      fill_in 'Name', :with => 'Test Loan'
      fill_in 'Period', :with => 20
      fill_in 'Rate of interest', :with => 12

      fill_in "Price", :with => 200
      #fill_in "Date", :with => "29-11-2010"
      fill_in "Quantity", :with => 30
      click_on "Create Net position"

      page.should have_content 'Test Loan'
      page.should have_content 200
      page.should have_content 30
    end

  end
end
