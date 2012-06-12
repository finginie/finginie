require 'spec_helper'

describe "MutualFundTransactions" do
  include_context "logged in user"
  let (:portfolio) { create :portfolio, :user => current_user }
  let (:scheme) { create :'data_provider/scheme', :nav_amount => "10" }

  before(:each) {
    scheme.save
  }

  it "should add a new mutual fund transaction to a portfolio" do
    visit new_portfolio_mutual_fund_transaction_path(portfolio)

    fill_in 'mutual_fund_transaction_scheme', :with => scheme.name
    fill_in 'mutual_fund_transaction_price', :with => 1000
    select 'Buy', :from => "Action"
    fill_in I18n.t("simple_form.labels.mutual_fund_transaction.quantity"), :with => 20
    click_on I18n.t("helpers.submit.mutual_fund_transaction.create")
    page.should have_content "successfully"
    current_path.should eq details_portfolio_path(portfolio)
  end

  it "should not add a new sell transaction if the quantity for that mutual fund is not available in the portfolio" do
    visit new_portfolio_mutual_fund_transaction_path(portfolio)
    fill_in 'mutual_fund_transaction_scheme', :with => scheme.name
    fill_in I18n.t("simple_form.labels.mutual_fund_transaction.price"), :with => 200
    select 'Sell', :from => "Action"
    fill_in I18n.t("simple_form.labels.mutual_fund_transaction.quantity"), :with => 30
    click_on I18n.t("helpers.submit.mutual_fund_transaction.create")
    page.should_not have_content "successfully"
  end

  it "should autocomplete scheme name when user fill scheme name", :js => true do
    visit new_portfolio_mutual_fund_transaction_path(portfolio)
    page.execute_script %Q{ $('[data-autocomplete-source]').val("#{scheme.name[0..5]}").keydown(); }

    wait_until {  page.should have_selector(".ui-menu-item a:contains('#{scheme.name}')") }

    page.execute_script %Q{ $('.ui-menu-item a:contains("#{scheme.name}")').trigger('mouseenter').click(); }
    page.should have_field("Scheme", :with => scheme.name)
  end

  it "should show the index page" do
    create :mutual_fund_transaction, :scheme => scheme.name, :portfolio => portfolio,:quantity => 1, :price => 5, :date => Date.today
    visit portfolio_mutual_fund_transactions_path(portfolio)

    expected_table = [
                         [ I18n.l(Date.today), "Buy", scheme.name, "1", "5.00", "5.00", "-"]
                      ]
    tableish("table").should include *expected_table
  end

end
