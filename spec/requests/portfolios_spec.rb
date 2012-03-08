require 'spec_helper'

describe "Portfolios" do
  include_context "logged in user"
  let (:portfolio) { create :portfolio, :user => current_user }

  let(:stock) { create :stock }
  let(:scrip) { create :scrip, :last_traded_price => 5, :id => stock.symbol}
  let(:scheme) { create :scheme_master }
  let(:navcp) { create :navcp, :nav_amount => "5", :security_code => scheme.securitycode }
  let(:gold) { create :gold, :name => "Gold", :current_price => 5 }

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
                                  [stock.name, "10", "3.0", "5.0", "30.0", "50.0", "20.0"]
                                ]
    expected_table_for_mfs =    [
                                  ["Name", "Quantity", "Average Cost Price", "Market Price", "Amount Invested", "Market Value", "Profit"],
                                  [scheme.scheme_name, "10", "3.0", "5.0", "30.0", "50.0", "20.0"]
                                ]
    expected_table_for_gold =   [
                                  ["Name", "Quantity", "Average Cost Price", "Market Price", "Amount Invested", "Market Value", "Profit"],
                                  ["Gold", "10", "3.0", "5.0", "30.0", "50.0", "20.0"]
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
                       [ 8.months.ago.to_date.to_s(:db), "Foo", "10.0", "1.0","1,00,000.0", "1,06,578.78", "6,578.78", ""]
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
                       [ "2011-12-10", "Test Property", "50,000.0", "60,000.0", "10,000.0", ""],
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
                       [ 'Stocks',        "5.84",             "50.0"],
                       [ 'Mutual Funds',  "5.84",             "50.0"],
                       [ 'Gold',          "5.84",             "50.0"],
                       [ 'Fixed Deposits',"12.44",        "106.58"],
                       [ 'Real Estate',   "70.05",           "600.0"]
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
                       [ Date.today.to_s(:db), "buy", stock.name, "1", "5.0", "5.0", "Show", "Edit", "Destroy"],
                    ]
    expected_table_for_mutual_fund_transactions = [
                         [ "Date","Type", "Name", "Quantity", "Price", "Total Amount"],
                         [ Date.today.to_s(:db), "buy", scheme.scheme_name, "1", "5.0", "5.0", "Show", "Edit", "Destroy"],
                      ]
    tableish("section.StockTransactions table").should eq expected_table_for_stock_transactions
    tableish("section.MutualFundTransactions table").should eq expected_table_for_mutual_fund_transactions
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

    real_estate = create :real_estate, :name => "Test Property", :location => "Mordor", :current_price => 600
    create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 500, :date => Date.civil(2011, 12, 01)
  end
end
