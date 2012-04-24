require 'spec_helper'

describe PortfolioDecorator, :redis, :mongoid do
  before { ApplicationController.new.set_current_view_context }
  let(:portfolio) { create :portfolio }
  let(:company) { create :company_with_scrip, :industry_name => "FOO" }
  let(:scheme) { create :scheme, :scheme_class_description => "FOO", :nav_amount => "5" }
  let(:real_estate) { create :real_estate, :name => "Test Property", :location => "Mordor", :current_price => 600 }
  let(:fixed_deposit) { create :fixed_deposit, :name => "Foo", :period => 5, :rate_of_interest => 10.0 }

  subject {
    create_securities
    PortfolioDecorator.decorate(portfolio)
  }

  its(:stocks_percentage) { should eq 5.84 }
  its(:mutual_funds_percentage) { should eq 5.84 }
  its(:gold_percentage) { should eq 5.84 }
  its(:fixed_deposits_percentage) { should eq 12.44 }
  its(:real_estates_percentage) { should eq 70.05 }

  it"should have sector_wise_stock_percentage" do
    another_company = create :company_with_scrip, :industry_name => "BAR"
    create :stock_transaction, :company_code => another_company.company_code, :portfolio => portfolio, :quantity => 4, :price => 6, :date => 5.days.ago

    subject.sector_wise_stock_percentage.should include(*[["FOO", 71.43], ["BAR", 28.57]])
  end

  it"should have stocks sell positions" do
    subject
    create :stock_transaction, :company_code => company.company_code, :portfolio => portfolio, :quantity => 4, :price => 6, :date => Date.today, :action => "sell"
    another_company = create :company_with_scrip, :industry_name => "BAR"
    create :stock_transaction, :company_code => another_company.company_code, :portfolio => portfolio, :quantity => 4, :price => 6, :date => 5.days.ago
    create :stock_transaction, :company_code => another_company.company_code, :portfolio => portfolio, :quantity => 4, :price => 5, :date => Date.today, :action => "sell"

    subject.stocks_positions_profit_or_loss.should include(*[{ "name" => company.company_name, "type" => "Stock", "sector" => "FOO", "profit_or_loss" => 12.0 ,
                                                                "percentage" => 100.0, "average_sell_price" => 6.0, "quantity" => 4,"average_cost_price" => 4.0},
                                                             {"name" => another_company.company_name, "type" => "Stock", "sector" => "BAR", "profit_or_loss" => -4.0,
                                                                "percentage" => -16.67, "average_sell_price" => 5.0, "quantity" => 4, "average_cost_price" => 6.0}])
  end

  it "should have catogorywise mf percentages" do
    subject
    scheme2 = create :scheme, :nav_amount => "5", :scheme_class_description => "BAR"
    create :mutual_fund_transaction, :scheme => scheme2.scheme_name, :portfolio => portfolio, :quantity => 4, :price => 6, :date => Date.today
    subject.category_wise_mutual_funds_percentage.should include(*[["FOO", 71.43], ["BAR", 28.57]])
  end

  it "should have mutual fund sell positions" do
    subject
    scheme2 = create :scheme, :scheme_class_description => "BAR"
    create :mutual_fund_transaction, :scheme => scheme.scheme_name, :portfolio => portfolio, :quantity => 4, :price => 6, :date => Date.today, :action => "sell"
    create :mutual_fund_transaction, :scheme => scheme2.scheme_name, :portfolio => portfolio, :quantity => 1, :price => 5, :date => 2.days.ago
    create :mutual_fund_transaction, :scheme => scheme2.scheme_name, :portfolio => portfolio, :quantity => 1, :price => 4, :date => 1.days.ago, :action => "sell"

    subject.mutual_fund_positions_profit_or_loss.should include(*[ { "name" => scheme.scheme_name, "type" => "Mutual Fund", "category" => "FOO", "profit_or_loss" => 12.0,
                                                                      "percentage" => 100.0, "average_sell_price"=>6.0, "quantity" => 4, "average_cost_price" => 4.0},
                                                                   { "name" => scheme2.scheme_name, "type" => "Mutual Fund", "category" => "BAR", "profit_or_loss" => -1.0,
                                                                      "percentage" => -20.0, "average_sell_price"=>4.0, "quantity" => 1, "average_cost_price" => 5.0}] )
  end

  it "should have fixed deposit open positions rate of interests" do
    subject
    fixed_deposit2 = create :fixed_deposit, :name => "BAR", :period => 5, :rate_of_interest => 12.0
    create :fixed_deposit_transaction, :fixed_deposit => fixed_deposit2, :portfolio => portfolio, :price => 1000, :date => 5.months.ago.to_date
    subject.fixed_deposit_open_positions_rate_of_interests.should include(*[{"rate"=>10.0, "name"=>"Foo", "amount"=>100.0}, {"rate"=>12.0, "name"=>"BAR", "amount"=>1000.0}])
  end

  it "should give top five profits", :mongoid do
    Timecop.freeze(Date.civil(2012,03,22)) do
      another_portfolio = create :portfolio
      create_securities(another_portfolio)

      create_sell_position_of_all_securities_type(another_portfolio)

      expected = [ { "name" => "Test Property",   "type" => "Real Estate",   "profit_or_loss" => 400.0, "percentage" => 80.0 },
                  { "name" => company.company_name, "type" => "Stock",  "sector" => "FOO", 
                    "profit_or_loss" => 12.0,  "percentage" => 100.0, "average_sell_price" => 6.0, "quantity" => 4.0, "average_cost_price" => 4.0},
                  { "name" => scheme.scheme_name, "type" => "Mutual Fund",   "category" => "FOO", "profit_or_loss" => 12.0,
                    "percentage" => 100, "average_sell_price"=>6.0 , "quantity" => 4.0, "average_cost_price" => 4.0},
                  { "name" => "Foo",              "type" => "Fixed Deposit", "profit_or_loss" => 4.64,  "percentage" => 4.64 } ]

      PortfolioDecorator.decorate(another_portfolio).top_five_profits.should include *expected
    end
  end

  it "should give top five losses", :mongoid do
    subject
    create_sell_position_of_all_securities_type
    expected = [ { "name" => "Test Property2",   "type" => "Real Estate", "profit_or_loss" => -400.0, "percentage" => -44.44},
                 { "name" => "Foo Scheme Name",  "type" => "Mutual Fund", "category" => "BAR", "profit_or_loss" => -1.0,
                   "percentage" => -20, "average_sell_price"=> 4.0 , "quantity" => 1, "average_cost_price" => 5.0},
                 { "name" => "FOO",              "type" => "Stock",       "sector" => "BAR", "profit_or_loss" => -4.0,
                   "percentage" => -16.67, "average_sell_price" => 5.0, "quantity" => 4, "average_cost_price" => 6.0} ]
    subject.top_five_losses.should include *expected
  end

  it "should have net profit/loss" do
    Timecop.freeze(Date.civil(2012,03,22)) do
      another_portfolio = create :portfolio
      create_securities(another_portfolio)

      create_sell_position_of_all_securities_type(another_portfolio)
      PortfolioDecorator.decorate(another_portfolio).net_profit_or_loss.should eq 23.64
    end
  end

  def create_securities(portfolio = portfolio)
    4.times { |n| create :stock_transaction, :company_code => company.company_code, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    4.times { |n|
      create :mutual_fund_transaction, :scheme => scheme.scheme_name, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    create :nse_scrip, :id => "GOLDBEES", :last_traded_price => 5
    4.times { |n| create :gold_transaction, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    loan =  create :loan, :name => "Foo Loan", :rate_of_interest => "10", :period => "1"
    loan_transaction =  create :loan_transaction, :loan => loan, :price => 1000, :date => 8.months.ago.to_date, :portfolio => portfolio

    create :fixed_deposit_transaction, :fixed_deposit => fixed_deposit, :portfolio => portfolio, :price => 100, :date => 8.months.ago.to_date

    create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 500, :date => Date.civil(2011, 12, 01), :action => "buy"
  end

  def create_sell_position_of_all_securities_type(portfolio = portfolio)
    create :stock_transaction, :company_code => company.company_code, :portfolio => portfolio, :quantity => 4, :price => 6, :date => Date.today, :action => "sell"
    another_company = create :company_with_scrip, :industry_name => "BAR", :company_name => "FOO"
    create :stock_transaction, :company_code => another_company.company_code, :portfolio => portfolio, :quantity => 4, :price => 6, :date => 5.days.ago
    create :stock_transaction, :company_code => another_company.company_code, :portfolio => portfolio, :quantity => 4, :price => 5, :date => Date.today, :action => "sell"

    create :mutual_fund_transaction, :scheme => scheme.scheme_name, :portfolio => portfolio, :quantity => 4, :action => 'sell', :price => 6, :date => Date.today
    scheme2 = create :scheme, :scheme_class_description => "BAR", :scheme_name => "Foo Scheme Name"
    create :mutual_fund_transaction, :scheme => scheme2.scheme_name, :portfolio => portfolio, :quantity => 1, :price => 5, :date => 2.days.ago
    create :mutual_fund_transaction, :scheme => scheme2.scheme_name, :portfolio => portfolio, :quantity => 1, :price => 4, :date => 1.days.ago, :action => "sell"

    fixed_deposit.update_attributes(:rate_of_redemption => 8.0)
    create :fixed_deposit_transaction, :fixed_deposit => fixed_deposit, :portfolio => portfolio, :price => 100, :date => 1.months.ago.to_date, :action => "sell"

    create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 900, :date => Date.civil(2012, 2, 01), :action => "sell"
    real_estate_2 = create :real_estate, :name => "Test Property2", :location => "Mordor", :current_price => 500
    create :real_estate_transaction, :real_estate => real_estate_2, :portfolio => portfolio, :price => 900, :date => Date.civil(2011, 12, 01)
    create :real_estate_transaction, :real_estate => real_estate_2, :portfolio => portfolio, :price => 500, :date => Date.civil(2012, 01, 01), :action => "sell"
  end
end
