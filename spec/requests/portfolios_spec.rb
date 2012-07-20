require 'spec_helper'

describe "Portfolios", :mongoid do
  include_context "logged in user"
  let (:portfolio) { create :portfolio, :user => current_user }

  let(:company) { create :company_with_scrip, :industry_name => "FOO" }
  let(:scheme) { create :'data_provider/scheme', :nav_amount => "5", :class_description => "FOO"}
  let(:real_estate) { create :real_estate, :name => "Test Property", :location => "Mordor", :current_price => 600 }
  let(:fixed_deposit) { create :fixed_deposit, :name => "Foo", :period => 5, :rate_of_interest => 10.0 }

  it "should show all net positions in details page" do
    4.times { |n| create :stock_transaction, :company_code => company.code, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }
    4.times { |n| create :mutual_fund_transaction, :scheme => scheme.name,
                          :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }
    4.times { |n| create :gold_transaction, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    company_without_current_price = create :'data_provider/company'
    create :stock_transaction, :company_code => company_without_current_price.code, :quantity => 10, :price => 5, :date => 5.days.ago, :portfolio => portfolio

    create :'data_provider/nse_scrip', :id => "GOLDBEES", :last_traded_price => 5

    visit details_portfolio_path(portfolio)

    expected_table_for_stocks = [
                                  [company.name,                       "10.00", "3.00",  "30.00", "5.00", "50.00", "20.00", "66.67","Sell"],
                                  [company_without_current_price.name, "10.00", "5.00",  "50.00", "-",    "-",     "-" ,    "-",    "Sell"],
                                  ["Total",                                    "",      "",      "80.00", "",     "50.00", "20.00", "" ,    ""    ]
                                ]
    expected_table_for_mfs =    [
                                  [scheme.name, "10.00", "3.00", "30.00", "5.00", "50.00", "20.00", "66.67", "Sell"],
                                  ["Total",            "",      "",     "30.00", "",     "50.00", "20.00", "",      ""]
                                ]
    expected_table_for_gold =   [
                                  ["Gold", "10.00", "3.00", "30.00", "5.00", "50.00", "20.00", "66.67", "Sell"]
                                ]

    within "#stock_positions" do
      tableish("table").should include *expected_table_for_stocks
    end

    within "#mutual_fund_positions" do
      tableish("table").should include *expected_table_for_mfs
    end

    within "#gold_positions" do
      tableish("table").should include *expected_table_for_gold
    end
  end

  it "should go to stock page when a stock in details page is clicked" do
    4.times { |n| create :stock_transaction, :company_code => company.code, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }
    visit details_portfolio_path(portfolio)
    click_link company.name
    page.current_path.should eq stock_path(company)
  end

  it "should go to mutual fund page when a mutual fund in details page is clicked" do
    4.times { |n| create :mutual_fund_transaction, :scheme => scheme.name,
                          :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    visit details_portfolio_path(portfolio)
    click_link scheme.name
    page.current_path.should eq mutual_fund_path(scheme)
  end

  it "should show loan net position in details page" do
    loan = create :loan, :period => 1, :rate_of_interest => 10, :name => "Test Loan"
    create :loan_transaction, :loan => loan, :portfolio => portfolio, :price => 100000, :date => 8.months.ago.to_date, :action => "borrow"

    visit details_portfolio_path(portfolio)
    expected_table = [
                       [ "Test Loan", I18n.l(8.months.ago.to_date), "10.0", "1.0",   "25,941.32", "Clear Loan"],
                       [ "Total",     "",                           "",     "",      "25,941.32", ""          ]
                    ]
    tableish("section.Loan table").should include *expected_table
  end

  it "user should able to clear the loan" do
    loan = create :loan, :period => 1, :rate_of_interest => 10, :name => "Test Loan"
    create :loan_transaction, :loan => loan, :portfolio => portfolio, :price => 100000, :date => 8.months.ago.to_date, :action => "borrow"

    visit details_portfolio_path(portfolio)
    click_on "Clear Loan"
    page.should have_content "Successfully cleared the loan"
    current_path.should eq details_portfolio_path(portfolio)
    page.should_not have_selector("section.Loan table")
  end

  it "should show fixed deposit net position in details page" do
    Timecop.freeze(Date.civil(2012,03,22)) do
      fixed_deposit = create :fixed_deposit, :period => 1, :rate_of_interest => 10, :name => "Foo"
      create :fixed_deposit_transaction, :fixed_deposit => fixed_deposit, :portfolio => portfolio, :price => 100000, :date => 8.months.ago.to_date
      create :fixed_deposit_transaction, :fixed_deposit => create(:fixed_deposit, :period => 1, :rate_of_interest => 10, :name => "Foo"),
                                         :portfolio => portfolio, :price => 100000, :date => 8.months.ago.to_date

      visit details_portfolio_path(portfolio)
      expected_table = [
                         [ "Foo",   I18n.l(8.months.ago.to_date), "10.0",  "1.0",   "1,00,000.00", "1,06,578.78", "6,578.78",  "6.58", "Redeem"],
                         [ "Foo",   I18n.l(8.months.ago.to_date), "10.0",  "1.0",   "1,00,000.00", "1,06,578.78", "6,578.78",  "6.58", "Redeem"],
                         [ "Total", "",    "", "",                                  "2,00,000.00", "2,13,157.56", "13,157.56", "",     ""      ]
                      ]
      tableish("section.FixedDeposit table").should include *expected_table
    end
  end

  it "user should able to redeem the fixed deposit" do
    fixed_deposit = create :fixed_deposit, :period => 1, :rate_of_interest => 10, :name => "Foo"
    create :fixed_deposit_transaction, :fixed_deposit => fixed_deposit, :portfolio => portfolio, :price => 100000, :date => 8.months.ago.to_date

    visit details_portfolio_path(portfolio)
    click_on "Redeem"
    fill_in "fixed_deposit_transaction_rate_of_redemption", :with => "8"
    click_on "Submit"
    page.should_not have_selector("section.FixedDeposit table")
  end

  it "should show real estate net position in details page" do
    real_estate = create :real_estate, :name => "Test Property", :location => "Mordor", :current_price => 60000
    create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 50000, :date => Date.civil(2011,12,10), :action => "buy"

    visit details_portfolio_path(portfolio)
    expected_table = [
                       [ "Test Property", "50,000.00", "60,000.00", "10,000.00", "20.00", "Sell"],
                       [ "Total",         "50,000.00", "60,000.00", "10,000.00", ""     , ""    ]
                    ]
    tableish("section.RealEstate table").should include *expected_table
  end

   it "user should able to sell real estate property" do
    real_estate = create :real_estate,:name => "Test Property", :location => "Mordor", :current_price => 60000
    create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 100000, :date => 8.months.ago.to_date, :action => "buy"

    visit details_portfolio_path(portfolio)
    click_on "Sell"
    fill_in I18n.t("simple_form.labels.real_estate_transaction.sell.price"), :with => 120000
    click_on "Submit"
    page.should_not have_selector("section.RealEstate table")
  end

  it "should show the summary in show page" do
    create_positions_of_all_securities

    visit portfolio_path(portfolio)
    expected_asset_table = [
                             [ 'Stocks',           "50" ,  "5.84"],
                             [ 'Mutual Funds',     "50" ,  "5.84"],
                             [ 'Gold',             "50" ,  "5.84"],
                             [ 'Fixed Deposits',   "107", "12.44"],
                             [ 'Real Estate',      "600", "70.05"],
                             [ "Total",            "857",      ""]
                          ]

    expected_liabilities_table = [
                                   ["Loans",     "259", "100.00"],
                                   ["Total",     "259",       ""],
                                   ["Net Worth", "598",       ""]
                                  ]
    tableish("table.assets").should include *expected_asset_table
    tableish("table.liabilities").should include *expected_liabilities_table
  end

  context "new portfolio" do
    let(:new_portfolio) { create :portfolio, :user => current_user }

    before(:each) do
      visit portfolio_path(new_portfolio)
    end

    it "should display default message" do
      page.should have_content I18n.t("portfolios.empty_transaction.message")
    end

    it "should display default message for stock when there is no stock transaction" do
      visit stocks_analysis_portfolio_path(new_portfolio)
      page.should have_content I18n.t("portfolios.stocks_analysis.no_stock_transaction")
    end

    it "should display default message for mutual funds when there is no mutual fund transaction" do
      visit mutual_funds_analysis_portfolio_path(new_portfolio)
      page.should have_content I18n.t("portfolios.mutual_funds_analysis.no_mutual_fund_transaction")
    end

    it "should display default message for fixed deposit when there is no fixed deposit transaction" do
      visit fixed_deposits_analysis_portfolio_path(new_portfolio)
      page.should have_content I18n.t("portfolios.fixed_deposits_analysis.no_fixed_deposit_transaction")
    end

    it "should display default messages in Accumulated Profits page" do
      visit accumulated_profits_portfolio_path(new_portfolio)
      page.should have_content I18n.t("portfolios.accumulated_profits.no_profit_or_loss")
    end

    it "should display default messages in Details Page" do
      visit details_portfolio_path(new_portfolio)
      page.should have_content I18n.t("portfolios.empty_transaction.message")
    end

    it "should display default messages in Transactions page" do
      visit transactions_portfolio_path(new_portfolio)
      page.should have_content I18n.t("portfolios.transactions.empty_transactions")
    end
  end

  it "should show all transactions in transactions page" do
    create :stock_transaction, :company_code => company.code, :portfolio => portfolio, :quantity => 1, :price => 5, :date => Date.today
    create :mutual_fund_transaction, :scheme => scheme.name, :portfolio => portfolio,:quantity => 1, :price => 5, :date => Date.today

    visit portfolio_path(portfolio)
    click_link 'Historical Transactions'

    expected_table_for_stock_transactions = [
                       [ I18n.l(Date.today), "Buy", company.name, "1", "5.00", "5.00", "-"],
                    ]
    expected_table_for_mutual_fund_transactions = [
                         [ I18n.l(Date.today), "Buy", scheme.name, "1", "5.00", "5.00", "-"],
                      ]
    tableish("section.StockTransactions table").should include *expected_table_for_stock_transactions
    tableish("section.MutualFundTransactions table").should include *expected_table_for_mutual_fund_transactions
  end

  it "should show stocks analysis table" do
    create_positions_of_all_securities
    another_company = create :company_with_scrip, :industry_name => "BAR"
    create :stock_transaction, :company_code => another_company.code, :portfolio => portfolio, :quantity => 4, :price => 6, :date => 5.days.ago
    visit stocks_analysis_portfolio_path(portfolio)

    expected_table = [
                        ["FOO",                        "",     "-",    "-",     "-",    "50.00",  "-",     "71.43"],
                        [company.name,         "10", "3.00", "30.00", "5.00", "50.00",  "20.00", "71.43"],
                        ["BAR",                        "",     "-",    "-",     "-",    "20.00",  "-",     "28.57"],
                        [another_company.name, "4",  "6.00", "24.00", "5.00", "20.00",  "-4.00", "28.57"],
                        ["Total",                      "",     "",     "",      "",     "70.00",  ""      , ""     ]
                     ]
    tableish("table").should include *expected_table
  end

  it "should show mutual funds analysis table" do
    create_positions_of_all_securities
    scheme2 = create :'data_provider/scheme', :nav_amount => "5", :class_description => "BAR"
    create :mutual_fund_transaction, :scheme => scheme2.name, :portfolio => portfolio, :quantity => 4, :price => 6, :date => Date.today

    visit mutual_funds_analysis_portfolio_path(portfolio)
    expected_table = [
                        ["FOO",               "",     "-",    "-",     "-",    "50.00",  "-",     "71.43"],
                        [scheme.name,  "10", "3.00", "30.00", "5.00", "50.00",  "20.00", "71.43"],
                        ["BAR",               "",     "-",    "-",     "-",    "20.00",  "-",     "28.57"],
                        [scheme2.name, "4",  "6.00", "24.00", "5.00", "20.00",  "-4.00", "28.57"],
                        ["Total",             "",     "",     "",      "",     "70.00",  ""      , ""     ]
                     ]
    tableish("table").should include(*expected_table)
  end

  it "should have Profit/Loss page" do
    Timecop.freeze(Date.civil(2012,03,22)) do
      another_portfolio = create :portfolio, :user => current_user
      create_positions_of_all_securities(another_portfolio)
      create_sell_position_of_all_securities_type(another_portfolio)

      visit accumulated_profits_portfolio_path(another_portfolio)

      expected_table_profits = [ ["Test Property", "Real Estate", "", "", "", "400.00", "80.00"],
                                 [company.name, "Stock", "4", "4.00", "6.00", "12.00", "100.00"],
                                 [scheme.name, "Mutual Fund","4", "4.00", "6.00", "12.00", "100.00"],
                                 ["Foo", "Fixed Deposit", "", "", "","4.64", "4.64"] ]
      expected_table_losses = [ ["Test Property2", "Real Estate","", "", "","-400.00", "-44.44"],
                                ["FOO", "Stock", "4", "6.00", "5.00","-4.00", "-16.67"],
                                ["Foo Scheme Name", "Mutual Fund", "1", "5.00", "4.00", "-1.00", "-20.00"]]

      tableish("#accumulated_profits table").should include *expected_table_profits
      tableish("#accumulated_losses table").should include *expected_table_losses
      page.should have_content 23.64
    end
  end

  it "should display flash message where there is no portfolio" do
    Portfolio.destroy_all
    visit portfolios_path
    page.should have_content I18n.t("portfolios.index.empty_portfolio")
  end

  it "should display stocks profits/losses in stocks analysis page" do
    create_positions_of_all_securities
    create :stock_transaction, :company_code => company.code, :portfolio => portfolio, :quantity => 4, :price => 6, :date => Date.today, :action => "sell"
    another_company = create :company_with_scrip, :industry_name => "BAR"
    create :stock_transaction, :company_code => another_company.code, :portfolio => portfolio, :quantity => 4, :price => 6, :date => 5.days.ago
    create :stock_transaction, :company_code => another_company.code, :portfolio => portfolio, :quantity => 4, :price => 5, :date => Date.today, :action => "sell"

    visit stocks_analysis_portfolio_path(portfolio)
    expected_table = [ [ company.name,         "FOO", "4", "4.0", "6.0", "12.00", "100.00" ],
                       [ another_company.name, "BAR", "4", "6.0", "5.0", "-4.00", "-16.67" ],
                       [ "Total",                      "",    "",  "",    "",    "8.00",  ""       ] ]

    tableish("#stocks_profit_or_loss_analysis table").should include *expected_table
  end

  it "should display mutual funds profits/losses in mutual funds anyalysis page" do
    create_positions_of_all_securities
    scheme2 = create :'data_provider/scheme', :class_description => "BAR"
    create :mutual_fund_transaction, :scheme => scheme.name, :portfolio => portfolio, :quantity => 4, :price => 6, :date => Date.today, :action => "sell"
    create :mutual_fund_transaction, :scheme => scheme2.name, :portfolio => portfolio, :quantity => 1, :price => 5, :date => 2.days.ago
    create :mutual_fund_transaction, :scheme => scheme2.name, :portfolio => portfolio, :quantity => 1, :price => 4, :date => 1.days.ago, :action => "sell"

    visit mutual_funds_analysis_portfolio_path(portfolio)
    expected_table = [
                      [ scheme.name, "FOO",  "4",  "4.0", "6.0", "12.00", "100.00" ],
                      [ scheme2.name, "BAR", "1",  "5.0", "4.0", "-1.00", "-20.00" ],
                      [ "Total", "",                "",   "",    "",    "11.00", ""       ]
                     ]
    tableish("#mfs_profit_or_loss_analysis table").should include *expected_table
  end

  it "should allow user to sell stocks in current holding page" do
    company.save
    4.times { |n| create :stock_transaction, :company_code => company.code, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }
    visit details_portfolio_path(portfolio)

    click_link "Sell"

    page.should have_field('stock_transaction_quantity',     :with => '10'    )
    page.should have_field('stock_transaction_action',       :with => 'sell'  )
    page.should have_field('stock_transaction_company_code', :with => company.code.to_s)
  end

  it "should allow user to sell mutual fund in current holding page" do
    4.times { |n| create :mutual_fund_transaction, :scheme => scheme.name,
                          :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    visit details_portfolio_path(portfolio)

    click_link "Sell"

    page.should have_field('mutual_fund_transaction_scheme',    :with => scheme.name)
    page.should have_field('mutual_fund_transaction_quantity',  :with => '10')
    page.should have_field('mutual_fund_transaction_action',    :with => 'sell')
  end

  it "should allow user to sell gold in current holding page" do
    4.times { |n| create :gold_transaction, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    visit details_portfolio_path(portfolio)

    click_link "Sell"

    page.should have_field('gold_transaction_quantity',  :with => '10')
    page.should have_field('gold_transaction_action',    :with => 'sell')
  end

  def create_positions_of_all_securities(portfolio = portfolio)
    4.times { |n| create :stock_transaction, :company_code => company.code, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    4.times { |n| create :mutual_fund_transaction, :scheme => scheme.name, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    4.times { |n| create :gold_transaction, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    loan =  create :loan, :name => "Foo Loan", :rate_of_interest => "10", :period => "1"
    loan_transaction =  create :loan_transaction, :loan => loan, :price => 1000, :date => 8.months.ago.to_date, :portfolio => portfolio, :action => "borrow"

    create :fixed_deposit_transaction, :fixed_deposit => fixed_deposit, :portfolio => portfolio, :price => 100, :date => 8.months.ago.to_date

    create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 500, :date => Date.civil(2011, 12, 01)
  end

  def create_sell_position_of_all_securities_type(portfolio = portfolio)
    create :stock_transaction, :company_code => company.code, :portfolio => portfolio, :quantity => 4, :price => 6, :date => Date.today, :action => "sell"
    another_company = create :company_with_scrip, :industry_name => "BAR", :name => "FOO"
    create :stock_transaction, :company_code => another_company.code, :portfolio => portfolio, :quantity => 4, :price => 6, :date => 5.days.ago
    create :stock_transaction, :company_code => another_company.code, :portfolio => portfolio, :quantity => 4, :price => 5, :date => Date.today, :action => "sell"

    create :mutual_fund_transaction, :scheme => scheme.name, :portfolio => portfolio, :quantity => 4, :price => 6, :date => Date.today, :action => "sell"
    scheme2 = create :'data_provider/scheme', :class_description => "BAR", :name => "Foo Scheme Name"

    create :mutual_fund_transaction, :scheme => scheme2.name, :portfolio => portfolio, :quantity => 1, :price => 5, :date => 2.days.ago
    create :mutual_fund_transaction, :scheme => scheme2.name, :portfolio => portfolio, :quantity => 1, :price => 4, :date => 1.days.ago, :action => "sell"

    fixed_deposit.update_attributes(:rate_of_redemption => 8.0)
    create :fixed_deposit_transaction, :fixed_deposit => fixed_deposit, :portfolio => portfolio, :price => 100, :date => 1.months.ago.to_date, :action => "sell"

    create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 900, :date => Date.civil(2012, 2, 01), :action => "sell"
    real_estate_2 = create :real_estate, :name => "Test Property2", :location => "Mordor", :current_price => 500
    create :real_estate_transaction, :real_estate => real_estate_2, :portfolio => portfolio, :price => 900, :date => Date.civil(2011, 12, 01)
    create :real_estate_transaction, :real_estate => real_estate_2, :portfolio => portfolio, :price => 500, :date => Date.civil(2012, 01, 01), :action => "sell"
  end

end
