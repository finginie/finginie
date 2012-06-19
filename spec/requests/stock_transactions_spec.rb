require 'spec_helper'

describe "StockTransactions" do
  describe "GET /stock_transactions", :mongoid do
    include_context "logged in user"
    let (:portfolio) { create :portfolio, :user => current_user }
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get portfolio_stock_transactions_path(portfolio)
      response.status.should be(200)
    end

    let (:company) { create :company_with_scrip }
    it "should add a new stock transaction to a portfolio" do
      company.save # ensure stock is created
      visit  new_portfolio_stock_transaction_path(portfolio)
      select company.name, :from => "stock_transaction_company_code"

      fill_in "Price", :with => 200
      select 'Buy', :from => "Action"
      fill_in I18n.t("simple_form.labels.stock_transaction.quantity"), :with => 30
      click_on I18n.t("helpers.submit.stock_transaction.create")
      page.should have_content "successfully"
      current_path.should eq details_portfolio_path(portfolio)
    end

    it "should not add a new sell transaction if the quantity for that stock is not available in the portfolio" do
      company.save
      visit new_portfolio_stock_transaction_path(portfolio)
      select company.name, :from => "stock_transaction_company_code"
      fill_in "Price", :with => 200
      select 'Sell', :from => "Action"
      fill_in I18n.t("simple_form.labels.stock_transaction.quantity"), :with => 30
      click_on I18n.t("helpers.submit.stock_transaction.create")
      page.should have_selector(".error:contains('#{I18n.t("activerecord.errors.models.stock_transaction.insufficient", :security_name => company.name)}')")
      page.should_not have_content "successfully"
    end

    it "should show stock transactons index page" do
      create :stock_transaction, :company_code => company.code, :portfolio => portfolio, :quantity => 1, :price => 5, :date => Date.today
      visit transactions_portfolio_path(portfolio)
      expected_table = [
                         [ I18n.l(Date.today), "Buy", company.name, "1", "5.00", "5.00", "-"]
                      ]
      tableish("table").should include *expected_table
    end

    it "shouldn't throw error when company name is not found" do
      create :stock_transaction, :company_code => "12345", :portfolio => portfolio, :quantity => 1, :price => 5, :date => Date.today
      visit transactions_portfolio_path(portfolio)
      page.should have_content I18n.t("company_data_not_found")
    end
  end
end
