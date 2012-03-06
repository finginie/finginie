require 'spec_helper'

describe "RealEstateTransactions" do
  include_context "logged in user"
  let (:portfolio) { create :portfolio, :user => current_user }
  it "should add a new stock transaction to a portfolio" do
    visit  new_portfolio_real_estate_transaction_path(portfolio)
    fill_in 'Name', :with => 'Test Property'
    fill_in 'Location', :with => 'Mordor'
    fill_in 'Current price', :with => 9000000

    fill_in "Price", :with => 200

    click_on "Create"
    page.should have_content "successfully"
  end

  let (:real_estate) { create :real_estate, :name => "Test Property", :location => "Mordor", :current_price => 60000 }
  it "should show Real estate transactons index page" do
    create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 50000, :date => Date.civil(2011,12,10)

    visit portfolio_real_estate_transactions_path(portfolio)
    expected_table = [
                       [ "Date", "Type", "Name", "Buy Value", "Current Value", "Change (%)"],
                       [ "2011-12-10", "buy", "Test Property", "50,000.0", "60,000.0", "20.0", "Show", "Edit", "Destroy"],
                    ]
    tableish("table").should eq expected_table
  end

  it "user should sell real estate property" do
    real_estate_transaction = create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 5000, :date => Date.civil(2011,12,10)
    visit  sell_portfolio_real_estate_transaction_path(portfolio, real_estate_transaction)

    fill_in "Amount", :with => 5000
    click_on "Submit"
    page.should have_content "Successfully"
    current_path.should eq details_portfolio_path(portfolio)
  end
end
