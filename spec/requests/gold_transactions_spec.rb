require 'spec_helper'

describe "GoldTransactions" do
  include_context "logged in user"
  let (:portfolio) { create :portfolio, :user => current_user }
  let (:gold) { create :gold, :name => "Gold", :current_price => 2456 }
  it "should add a new gold transaction to a portfolio" do
    gold.save # ensure gold is created
    visit  new_portfolio_gold_transaction_path(portfolio)

    fill_in "Price", :with => 200
    select 'buy', :from => "Action"
    fill_in "Amount", :with => 30
    click_on "Create"
    page.should have_content "successfully"
  end

  it "should not add a new sell transaction if the quantity for gold is not available in the portfolio" do
    gold.save
    visit new_portfolio_gold_transaction_path(portfolio)
    fill_in "Price", :with => 200
    select 'sell', :from => "Action"
    fill_in "Amount", :with => 30
    click_on "Create"
    page.should_not have_content "successfully"
  end

  it "should show gold transactons index page" do
    create :gold_transaction, :gold => gold, :portfolio => portfolio, :quantity => 1, :price => 5, :date => Date.today
    visit portfolio_gold_transactions_path(portfolio)
    expected_table = [
                       [ "Date","Type", "Name", "Quantity", "Price", "Total Amount"],
                       [ Date.today.to_s(:db), "buy", "Gold", "1", "5.0", "5.0", "Show", "Edit", "Destroy"],
                    ]
    tableish("table").should eq expected_table
  end

end
