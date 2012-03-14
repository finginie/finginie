require 'spec_helper'

describe "StockTransactions" do
  describe "GET /stock_transactions" do
    include_context "logged in user"
    let (:portfolio) { create :portfolio, :user => current_user }
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get portfolio_stock_transactions_path(portfolio)
      response.status.should be(200)
    end

    let (:stock) { create :stock_with_scrip }
    it "should add a new stock transaction to a portfolio" do
      stock.save # ensure stock is created
      visit  new_portfolio_stock_transaction_path(portfolio)
      select stock.name, :from => "Stock"

      fill_in "Price", :with => 200
      select 'buy', :from => "Action"
      fill_in "Amount", :with => 30
      click_on "Create"
      page.should have_content "successfully"
      current_path.should eq portfolio_path(portfolio)
    end

    it "should not add a new sell transaction if the quantity for that stock is not available in the portfolio" do
      stock.save
      visit new_portfolio_stock_transaction_path(portfolio)
      select stock.name, :from => "Stock"
      fill_in "Price", :with => 200
      select 'sell', :from => "Action"
      fill_in "Amount", :with => 30
      click_on "Create"
      page.should_not have_content "successfully"
    end

    it "should show stock transactons index page" do
      create :stock_transaction, :stock => stock, :portfolio => portfolio, :quantity => 1, :price => 5, :date => Date.today
      visit portfolio_stock_transactions_path(portfolio)
      expected_table = [
                         [ "Date","Type", "Name", "Quantity", "Price", "Total Amount"],
                         [ Date.today.to_s(:db), "buy", stock.name, "1", "5.00", "5.00"]
                      ]
      tableish("table").should eq expected_table
    end
  end
end
