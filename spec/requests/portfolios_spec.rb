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
    page.should have_link 'Details'
    click_link 'Details'

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
                       [ 8.months.ago.to_date.to_s(:db), "Test Loan", "10.0", "1.0", "25,937.39", ""],
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
                       [ 8.months.ago.to_date.to_s(:db), "Foo", "10.0", "1.0","1,00,000.00", "1,06,578.78", "6,578.78", ""]
                    ]
    tableish("section.FixedDeposit table").should eq expected_table
  end

  it "user should able to redeem the fixed deposit" do
    fixed_deposit = create :fixed_deposit, :period => 1, :rate_of_interest => 10, :name => "Foo"
    create :fixed_deposit_transaction, :fixed_deposit => fixed_deposit, :portfolio => portfolio, :price => 100000, :date => 8.months.ago.to_date

    visit details_portfolio_path(portfolio)
    click_button "Redeem"
    fill_in "Rate of interest", :with => 8
    click_on "Submit"
    page.should_not have_selector("section.FixedDeposit table")
  end

  it "should show real estate net position in details page" do
    real_estate = create :real_estate, :name => "Test Property", :location => "Mordor", :current_price => 60000
    create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 50000, :date => Date.civil(2011,12,10)

    visit details_portfolio_path(portfolio)
    expected_table = [
                       [ "Date", "Name", "Buy Value", "Current Value", "Profit"],
                       [ "2011-12-10", "Test Property", "50,000.00", "60,000.00", "10,000.00", ""],
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
                       [ 'Asset Class', 'Percentage(%)', 'Amount' ],
                       [ 'Stocks',        "5.84",             "50.00"],
                       [ 'Mutual Funds',  "5.84",             "50.00"],
                       [ 'Gold',          "5.84",             "50.00"],
                       [ 'Fixed Deposits',"12.44",        "106.58"],
                       [ 'Real Estate',   "70.05",           "600.00"]
                      ]
    tableish("table").should eq expected_table
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
                       [ Date.today.to_s(:db), "buy", stock.name, "1", "5.00", "5.00"],
                    ]
    expected_table_for_mutual_fund_transactions = [
                         [ "Date","Type", "Name", "Quantity", "Price", "Total Amount"],
                         [ Date.today.to_s(:db), "buy", scheme.scheme_name, "1", "5.00", "5.00"],
                      ]
    tableish("section.StockTransactions table").should eq expected_table_for_stock_transactions
    tableish("section.MutualFundTransactions table").should eq expected_table_for_mutual_fund_transactions
  end

  it "should have accumulated profits page "do
    create_positions_of_all_securities
    create_sell_position_of_all_securities_type
    visit portfolio_path(portfolio)

    click_link 'Accumulated Profits'
    expected_table_profits = [["Test Property", "400.00"], [stock.name, "12.00"], [scheme.scheme_name, "12.00"], ["Foo", "4.64"]]
    expected_table_losses = [["Test Property2", "-400.00"], ["FOO", "-4.00"], ["Foo Scheme Name", "-1.00"]]

    tableish("#accumulated_profits table").should include *expected_table_profits
    tableish("#accumulated_losses table").should include *expected_table_losses
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
