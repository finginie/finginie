require 'spec_helper'

describe "GoldTransactions" do
  include_context "logged in user"
  let (:portfolio) { create :portfolio, :user => current_user }
  it "should add a new gold transaction to a portfolio" do
    Gold.current_price = 2456
    visit  new_portfolio_gold_transaction_path(portfolio)

    fill_in "Price", :with => 200
    select 'Buy', :from => "Action"
    fill_in I18n.t("simple_form.labels.gold_transaction.quantity"), :with => 30
    click_on I18n.t("helpers.submit.gold_transaction.create")
    page.should have_content "successfully"
    current_path.should eq details_portfolio_path(portfolio)
  end

  it "should not add a new sell transaction if the quantity for gold is not available in the portfolio" do
    Gold.current_price = 2456
    visit new_portfolio_gold_transaction_path(portfolio)
    fill_in "Price", :with => 200
    select 'Sell', :from => "Action"
    fill_in I18n.t("simple_form.labels.gold_transaction.quantity"), :with => 30
    click_on I18n.t("helpers.submit.gold_transaction.create")
    page.should_not have_content "successfully"
  end

  it "should show gold transactons index page" do
    Gold.current_price = 2456
    create :gold_transaction, :portfolio => portfolio, :quantity => 1, :price => 5, :date => Date.today, :action => 'buy'
    visit portfolio_gold_transactions_path(portfolio)
    expected_table = [
                       [ I18n.l(Date.today), "Buy", "Gold", "1", "5.00", "5.00", "-"],
                    ]
    tableish("table").should include *expected_table
  end

end
