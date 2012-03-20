require 'spec_helper'

describe "FixedDepositTransactions" do
  include_context "logged in user"
  let (:portfolio) { create :portfolio, :user => current_user }
  it "should add a new fixed deposit transaction to a portfolio" do
    visit  new_portfolio_fixed_deposit_transaction_path(portfolio)
    fill_in "Name", :with => "Foo"
    fill_in "Period", :with => "5"
    fill_in I18n.t("simple_form.labels.fixed_deposit_transaction.fixed_deposit.rate_of_interest"), :with => "10"

    fill_in I18n.t("simple_form.labels.fixed_deposit_transaction.price"), :with => 200
    click_on I18n.t("helpers.submit.fixed_deposit_transaction.create")
    page.should have_content "successfully"
    current_path.should eq details_portfolio_path(portfolio)
  end

  let (:fixed_deposit) { create :fixed_deposit, :period => 5, :rate_of_interest => 10 }
  it "should show Fixed deposit transactons index page" do
    create :fixed_deposit_transaction, :fixed_deposit => fixed_deposit, :portfolio => portfolio, :price => 5000, :date => Date.civil(2011,12,10)

    Timecop.freeze (Date.civil(2012, 03, 01)) do
      visit portfolio_fixed_deposit_transactions_path(portfolio)
      expected_table = [
                         [ I18n.l(Date.civil(2011,12,10)), "Buy", fixed_deposit.name, "10.0", "5.0", "5,000.00", "-"],
                      ]
      tableish("table").should include *expected_table
    end
  end

  it "user should redeem fixed deposit transaction" do
    fixed_deposit_transaction = create :fixed_deposit_transaction, :fixed_deposit => fixed_deposit, :portfolio => portfolio, :price => 5000, :date => Date.civil(2011,12,10)
    visit  redeem_portfolio_fixed_deposit_transaction_path(portfolio, fixed_deposit_transaction)

    fill_in I18n.t("simple_form.labels.fixed_deposit_transaction.fixed_deposit.rate_of_interest"), :with => "8"
    click_on "Submit"
    page.should have_content "Successfully"
    current_path.should eq details_portfolio_path(portfolio)
  end
end
