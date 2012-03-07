require 'spec_helper'

describe "LoanTransactions" do
  include_context "logged in user"
  let (:portfolio) { create :portfolio, :user => current_user }

  it "should add a new loan transaction to a portfolio" do
    visit  new_portfolio_loan_transaction_path(portfolio)
    fill_in "Name", :with => "Foo"
    fill_in "Period", :with => "5"
    fill_in "Rate of interest", :with => "10"

    fill_in "Amount", :with => 60000
    select 'borrow', :from => "Action"
    click_on "Create"
    page.should have_content "successfully"
  end

  let (:loan) { create :loan, :period => 5, :rate_of_interest => 10 }
  it "should show loan transactons index page" do
    create :loan_transaction, :loan => loan, :portfolio => portfolio, :price => -5000, :date => Date.civil(2011,12,10)

    Timecop.freeze (Date.civil(2012, 03, 01)) do
      visit portfolio_loan_transactions_path(portfolio)
      expected_table = [
                         ["Date", "Name", "Amount", "Rate of Interest", "Duration"],
                         [ "2011-12-10", loan.name, "5,000.0", "10.0", "5.0","Show", "Edit", "Destroy"]
                      ]
      tableish("table").should eq expected_table
    end
  end
end
