require 'spec_helper'

describe "NetPositions" do
  describe "Add new net position" do
    include_context "logged in user"

    let (:portfolio) { create :portfolio, :user => current_user }
    let (:stock) { create :stock }

    before :each do
      visit portfolio_path(portfolio)
    end

    it "adds new stock position" do
      stock.save # ensure stock is created
      click_on 'Add New Stock'
      page.should have_content 'New Stock'
      select stock.name, :from => "Security"

      fill_in "Price", :with => 200
      #fill_in "Date", :with => "29-11-2010"
      select 'buy', :from => "Action"
      fill_in "Quantity", :with => 30
      click_on "Stock"

      page.should have_content 'successfully created'
      page.should have_content stock.name
      page.should have_content 200
      page.should have_content 30
    end

    it "adds new fixed income position" do
      click_on 'Add New Fixed Income'
      page.should have_content 'New FixedIncome'
      fill_in 'Name', :with => 'Test Income'
      fill_in 'Period', :with => 20
      fill_in 'Rate of interest', :with => 12

      fill_in "Price", :with => 200
      #fill_in "Date", :with => "29-11-2010"
      select 'buy', :from => "Action"
      fill_in "Quantity", :with => 30
      click_on "FixedIncome"

      page.should have_content 'successfully created'
      page.should have_content 'Test Income'
      page.should have_content 200
      page.should have_content 30
    end

    it "adds new loan position" do
      click_on 'Add New Loan'
      page.should have_content 'New Loan'
      fill_in 'Name', :with => 'Test Loan'
      fill_in 'Period', :with => 20
      fill_in 'Rate of interest', :with => 12

      fill_in "Price", :with => 200
      #fill_in "Date", :with => "29-11-2010"
      select 'buy', :from => "Action"
      click_on "Loan"

      page.should have_content 'successfully created'
      page.should have_content 'Test Loan'
      page.should have_content 200
    end

    it "adds new real estate position" do
      click_on 'Add New Real Estate'
      fill_in 'Name', :with => 'Test Property'
      fill_in 'Location', :with => 'Mordor'
      fill_in 'Current price', :with => 9000000

      fill_in "Price", :with => 200
      #fill_in "Date", :with => "29-11-2010"
      select 'buy', :from => "Action"
      click_on "RealEstate"

      page.should have_content 'successfully created'
      page.should have_content 'Test Property'
      page.should have_content 200
    end

    it "adds new Gold position" do
      click_on 'Add New Gold'

      fill_in "Price", :with => 200
      #fill_in "Date", :with => "29-11-2010"
      select 'buy', :from => "Action"
      fill_in "Quantity", :with => 30
      click_on "Gold"

      page.should have_content 'successfully created'
      page.should have_content 'Gold'
      page.should have_content 200
      page.should have_content 30
     end

    let(:scheme_master) { create :scheme_master }
    it "adds new mutual fund position", :mongoid do
      scheme_master.save # ensure scheme master is created
      click_on 'Add New Mutual Fund'
      select scheme_master.scheme_name, :from => "Scheme"

      fill_in 'Price', :with => 10000
      #fill_in "Date", :with => "29-11-2010"
      select 'buy', :from => "Action"
      fill_in "Quantity", :with => 30
      click_on "MutualFund"

      page.should have_content 'successfully created'
      page.should have_content scheme_master.scheme_name
      page.should have_content 10000
      page.should have_content 30
    end
  end
end
