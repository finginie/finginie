require 'spec_helper'

describe "GoldTransactions" do
  include_context "logged in user"
  let (:portfolio) { create :portfolio, :user => current_user }
  let (:gold) { create :gold, :name => "Gold", :current_price => 2456 }
  it "should add a new gold transaction to a portfolio" do
    gold.save # ensure gold is created
    visit  new_portfolio_gold_transaction_path(portfolio)

    fill_in "Price", :with => 200
    select 'Buy', :from => "Action"
    fill_in I18n.t("simple_form.labels.gold_transaction.amount"), :with => 30
    click_on I18n.t("helpers.submit.gold_transaction.create")
    page.should have_content "successfully"
    current_path.should eq details_portfolio_path(portfolio)
  end

  it "should not add a new sell transaction if the quantity for gold is not available in the portfolio" do
    gold.save
    visit new_portfolio_gold_transaction_path(portfolio)
    fill_in "Price", :with => 200
    select 'Sell', :from => "Action"
    fill_in I18n.t("simple_form.labels.gold_transaction.amount"), :with => 30
    click_on I18n.t("helpers.submit.gold_transaction.create")
    page.should_not have_content "successfully"
  end

  it "should show gold transactons index page" do
    create :gold_transaction, :gold => gold, :portfolio => portfolio, :quantity => 1, :price => 5, :date => Date.today
    visit portfolio_gold_transactions_path(portfolio)
    expected_table = [
                       [ "Date","Type", "Name", "Quantity", "Price", "Total Amount"],
                       [ I18n.l(Date.today), "buy", "Gold", "1", "5.00", "5.00"],
                    ]
    tableish("table").should eq expected_table
  end

end
