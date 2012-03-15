require 'spec_helper'

describe "Portfolios" do
  include_context "logged in user"
  let (:portfolio) { create :portfolio, :user => current_user }

  let(:stock) { create :stock }
  let(:scrip) { create :scrip, :last_traded_price => 5, :id => stock.symbol}
  let(:scheme) { create :scheme_master }
  let(:navcp) { create :navcp, :nav_amount => "5", :security_code => scheme.securitycode }
  let(:gold) { create :gold, :name => "Gold", :current_price => 5 }
  let(:real_estate) { create :real_estate, :name => "Test Property", :location => "Mordor", :current_price => 600 }

  it "should show all net positions in details page" do
    scrip.save
    navcp.save
    4.times { |n| create :stock_transaction, :stock => stock, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }
    4.times { |n| create :mutual_fund_transaction, :mutual_fund => create(:mutual_fund, :name => scheme.scheme_name),
                          :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }
    4.times { |n| create :gold_transaction, :gold => gold, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }
    visit portfolio_path(portfolio)
    find("li#navigation-details").find("a").click

    expected_table_for_stocks = [
                                  ["Name", "Quantity", "Average Cost Price", "Market Price", "Amount Invested", "Market Value", "Profit"],
                                  [stock.name, "10.00", "3.00", "5.00", "30.00", "50.00", "20.00"]
                                ]
    expected_table_for_mfs =    [
                                  ["Name", "Quantity", "Average Cost Price", "Market Price", "Amount Invested", "Market Value", "Profit"],
                                  [scheme.scheme_name, "10.00", "3.00", "5.00", "30.00", "50.00", "20.00"]
                                ]
    expected_table_for_gold =   [
                                  ["Name", "Quantity", "Average Cost Price", "Market Price", "Amount Invested", "Market Value", "Profit"],
                                  ["Gold", "10.00", "3.00", "5.00", "30.00", "50.00", "20.00"]
                                ]

    within "#stock_positions" do
      tableish("table").should eq expected_table_for_stocks
    end

    within "#mutual_fund_positions" do
      tableish("table").should eq expected_table_for_mfs
    end

    within "#gold_positions" do
      tableish("table").should eq expected_table_for_gold
    end

    page.should have_link 'Add Stock'
    page.should have_link 'Add Mutual Fund'
    page.should have_link 'Add Gold'
    page.should have_link 'Add Fixed Deposit'
    page.should have_link 'Add Real Estate'
    page.should have_link 'Add Loan'
  end

  it "should show loan net position in details page" do
    loan = create :loan, :period => 1, :rate_of_interest => 10, :name => "Test Loan"
    create :loan_transaction, :loan => loan, :portfolio => portfolio, :price => -100000, :date => 8.months.ago.to_date

    visit details_portfolio_path(portfolio)
    expected_table = [
                       [ "Date", "Name", "Rate of Interest", "Duration", "Outstanding Amount"],
                       [ I18n.l(8.months.ago.to_date), "Test Loan", "10.0", "1.0", "25,937.39", ""],
                    ]
    tableish("section.Loan table").should eq expected_table
  end

  it "user should able to clear the loan" do
    loan = create :loan, :period => 1, :rate_of_interest => 10, :name => "Test Loan"
    create :loan_transaction, :loan => loan, :portfolio => portfolio, :price => -100000, :date => 8.months.ago.to_date

    visit details_portfolio_path(portfolio)
    click_button "clear the loan"
    page.should have_content "Successfully cleared the loan"
    current_path.should eq details_portfolio_path(portfolio)
    page.should_not have_selector("section.Loan table")
  end

  it "should show fixed deposit net position in details page" do
    fixed_deposit = create :fixed_deposit, :period => 1, :rate_of_interest => 10, :name => "Foo"
    create :fixed_deposit_transaction, :fixed_deposit => fixed_deposit, :portfolio => portfolio, :price => 100000, :date => 8.months.ago.to_date

    visit details_portfolio_path(portfolio)
    expected_table = [
                       [ "Date", "Name", "Rate of Interest", "Duration", "Invested Amount", "Current Value", "Profit"],
                       [ I18n.l(8.months.ago.to_date), "Foo", "10.0", "1.0","1,00,000.00", "1,06,578.78", "6,578.78", ""]
                    ]
    tableish("section.FixedDeposit table").should eq expected_table
  end

  it "user should able to redeem the fixed deposit" do
    fixed_deposit = create :fixed_deposit, :period => 1, :rate_of_interest => 10, :name => "Foo"
    create :fixed_deposit_transaction, :fixed_deposit => fixed_deposit, :portfolio => portfolio, :price => 100000, :date => 8.months.ago.to_date

    visit details_portfolio_path(portfolio)
    click_button "Redeem"
    fill_in I18n.t("simple_form.labels.fixed_deposit_transaction.fixed_deposit.rate_of_interest"), :with => "8"
    click_on "Submit"
    page.should_not have_selector("section.FixedDeposit table")
  end

  it "should show real estate net position in details page" do
    real_estate = create :real_estate, :name => "Test Property", :location => "Mordor", :current_price => 60000
    create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 50000, :date => Date.civil(2011,12,10)

    visit details_portfolio_path(portfolio)
    expected_table = [
                       [ "Date", "Name", "Buy Value", "Current Value", "Profit"],
                       [ I18n.l(Date.civil(2011,12,10)), "Test Property", "50,000.00", "60,000.00", "10,000.00", ""],
                    ]
    tableish("section.RealEstate table").should eq expected_table
  end

   it "user should able to sell real estate property" do
    real_estate = create :real_estate,:name => "Test Property", :location => "Mordor", :current_price => 60000
    create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 100000, :date => 8.months.ago.to_date

    visit details_portfolio_path(portfolio)
    click_button "Sell"
    fill_in "Amount", :with => 120000
    click_on "Submit"
    page.should_not have_selector("section.RealEstate table")
  end

  it "should show the summary in show page" do
    create_positions_of_all_securities

    visit portfolio_path(portfolio)
    expected_table = [
                       [ 'Asset Class',  'Percentage(%)',                  'Amount' ],
                       [ 'Stocks',         "5.84",                          "50.00"],
                       [ 'Mutual Funds',   "5.84",                          "50.00"],
                       [ 'Gold',           "5.84",                          "50.00"],
                       [ 'Fixed Deposits', "12.44",                         "106.58"],
                       [ 'Real Estate',    "70.05",                         "600.00"],
                       ["Total Assets",     "100",                          "856.58"],
                       ["Loans",            I18n.t("tables_not_available"), "258.63"],
                       ["Total Liabilities",I18n.t("tables_not_available"), "258.63"],
                       ["Net Worth",        I18n.t("tables_not_available"),  "597.95"]
                      ]
    tableish("table").should eq expected_table
  end

  context "new portfolio" do
    before(:each) do
      new_portfolio = create :portfolio, :user => current_user
      visit portfolio_path(new_portfolio)
    end

    it "should display default message" do
      page.should have_content I18n.t("portfolios.show.empty_transactions")
    end

    it "should display default message for stock when there is no stock transaction" do
      find("li#navigation-stocks_analysis").find("a").click
      page.should have_content I18n.t("portfolios.stocks_analysis.no_stock_transaction")
    end

    it "should display default message for mutual funds when there is no mutual fund transaction" do
      find("li#navigation-mutual_funds_analysis").find("a").click
      page.should have_content I18n.t("portfolios.mutual_funds_analysis.no_mutual_fund_transaction")
    end

    it "should display default message for fixed deposit when there is no fixed deposit transaction" do
      find("li#navigation-fixed_deposits_analysis").find("a").click
      page.should have_content I18n.t("portfolios.fixed_deposits_analysis.no_fixed_deposit_transaction")
    end

    it "should display default messages in Accumulated Profits page" do
      find("li#navigation-accumulated_profits").find("a").click
      page.should have_content I18n.t("portfolios.accumulated_profits.no_profit_or_loss")
    end

    it "should display default messages in Details Page" do
      find("li#navigation-details").find("a").click
      page.should have_content I18n.t("portfolios.details.no_stock_positions")
    end

    it "should display default messages in Transactions page" do
      find("li#navigation-transactions").find("a").click
      page.should have_content I18n.t("transactions.no_stock_transactions")
    end
  end

  it "should show all transactions in transactions page" do
    scrip.save
    navcp.save
    create :stock_transaction, :stock => stock, :portfolio => portfolio, :quantity => 1, :price => 5, :date => Date.today
    create :mutual_fund_transaction, :mutual_fund => create(:mutual_fund, :name => scheme.scheme_name), :portfolio => portfolio,:quantity => 1, :price => 5, :date => Date.today

    visit portfolio_path(portfolio)
    click_link 'Transactions'

    expected_table_for_stock_transactions = [
                       [ "Date","Type", "Name", "Quantity", "Price", "Total Amount"],
                       [ I18n.l(Date.today), "buy", stock.name, "1", "5.00", "5.00"],
                    ]
    expected_table_for_mutual_fund_transactions = [
                         [ "Date","Type", "Name", "Quantity", "Price", "Total Amount"],
                         [ I18n.l(Date.today), "buy", scheme.scheme_name, "1", "5.00", "5.00"],
                      ]
    tableish("section.StockTransactions table").should eq expected_table_for_stock_transactions
    tableish("section.MutualFundTransactions table").should eq expected_table_for_mutual_fund_transactions
  end

  it "should have Profit/Loss page "do
    create_positions_of_all_securities
    create_sell_position_of_all_securities_type
    visit portfolio_path(portfolio)

    find("li#navigation-accumulated_profits").find("a").click
    expected_table_profits = [["Test Property", "400.00"], [stock.name, "12.00"], [scheme.scheme_name, "12.00"], ["Foo", "4.64"]]
    expected_table_losses = [["Test Property2", "-400.00"], ["FOO", "-4.00"], ["Foo Scheme Name", "-1.00"]]

    tableish("#accumulated_profits table").should include *expected_table_profits
    tableish("#accumulated_losses table").should include *expected_table_losses
  end

  it "should display flash message where there is no portfolio" do
    Portfolio.destroy_all
    visit portfolios_path
    page.should have_content I18n.t("portfolios.index.empty_portfolio")
  end

  it "user can able to add transactions after selecting securities type", :js => true do
    create :gold, :name => "Gold", :current_price => 2456

    visit portfolio_path(portfolio)

    click_link "Add Transaction"
    current_path.should eq add_transaction_portfolio_path(portfolio)
    select "Gold", :from => "Type of investment"

    wait_until {  page.should have_selector("#new_gold_transaction") }

    fill_in "Price", :with => 200
    select 'Buy', :from => "Action"
    fill_in I18n.t("simple_form.labels.gold_transaction.amount"), :with => 30
    click_on I18n.t("helpers.submit.gold_transaction.create")
    page.should have_content "successfully"
    current_path.should eq details_portfolio_path(portfolio)
  end

  def create_positions_of_all_securities
    scrip.save
    4.times { |n| create :stock_transaction, :stock => stock, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    navcp.save
    4.times { |n| create :mutual_fund_transaction, :mutual_fund => create(:mutual_fund, :name => scheme.scheme_name), :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    4.times { |n| create :gold_transaction, :gold => gold, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    loan =  create :loan, :name => "Foo Loan", :rate_of_interest => "10", :period => "1"
    loan_transaction =  create :loan_transaction, :loan => loan, :price => -1000, :date => 8.months.ago.to_date, :portfolio => portfolio

    fixed_deposit = create :fixed_deposit, :name => "Foo", :period => 5, :rate_of_interest => 10.0
    create :fixed_deposit_transaction, :fixed_deposit => fixed_deposit, :portfolio => portfolio, :price => 100, :date => 8.months.ago.to_date

    create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 500, :date => Date.civil(2011, 12, 01)
  end

  def create_sell_position_of_all_securities_type
    create :stock_transaction, :stock => stock, :portfolio => portfolio, :quantity => -4, :price => 6, :date => Date.today
    stock1 = create :stock_with_scrip, :sector => "BAR", :name => "FOO"
    create :stock_transaction, :stock => stock1, :portfolio => portfolio, :quantity => 4, :price => 6, :date => 5.days.ago
    create :stock_transaction, :stock => stock1, :portfolio => portfolio, :quantity => 4, :price => 5, :date => Date.today, :action => :sell

    create :mutual_fund_transaction, :mutual_fund => create( :mutual_fund, :name => scheme.scheme_name), :portfolio => portfolio, :quantity => -4, :price => 6, :date => Date.today
    scheme2 = create :scheme_master, :scheme_class_description => "BAR", :scheme_name => "Foo Scheme Name"
    2.times { |n| create :mutual_fund_transaction, :mutual_fund => create(:mutual_fund, :name => scheme2.scheme_name),
                                                   :portfolio => portfolio, :quantity => 1- n * (n +1),
                                                   :price => -n+5, :date => (-n +2).days.ago }

    fixed_deposit = create :fixed_deposit, :name => "Foo", :period => 5, :rate_of_interest => 8.0
    create :fixed_deposit_transaction, :fixed_deposit => fixed_deposit, :portfolio => portfolio, :price => -100, :date => 1.months.ago.to_date

    create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => -900, :date => Date.civil(2012, 2, 01)
    real_estate_2 = create :real_estate, :name => "Test Property2", :location => "Mordor", :current_price => 500
    create :real_estate_transaction, :real_estate => real_estate_2, :portfolio => portfolio, :price => 900, :date => Date.civil(2011, 12, 01)
    create :real_estate_transaction, :real_estate => real_estate_2, :portfolio => portfolio, :price => -500, :date => Date.civil(2012, 01, 01)
  end

end
