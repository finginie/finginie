require 'spec_helper'

describe PortfolioDecorator do
  before { ApplicationController.new.set_current_view_context }
  let (:portfolio) { create :portfolio }
  let(:stock) { create :stock, :sector => "FOO" }
  let(:scheme) { create :scheme_master, :scheme_class_description => "FOO" }
  let(:real_estate) { create :real_estate, :name => "Test Property", :location => "Mordor", :current_price => 600 }

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
    stock1 = create :stock_with_scrip, :sector => "BAR"
    create :stock_transaction, :stock => stock1, :portfolio => portfolio, :quantity => 4, :price => 6, :date => 5.days.ago

    subject.sector_wise_stock_percentage.should include(*[["FOO", 71.43], ["BAR", 28.57]])
  end

  it"should have stocks sell positions" do
    subject
    create :stock_transaction, :stock => stock, :portfolio => portfolio, :quantity => 4, :price => 6, :date => Date.today, :action => "sell"
    stock1 = create :stock_with_scrip, :sector => "BAR"
    create :stock_transaction, :stock => stock1, :portfolio => portfolio, :quantity => 4, :price => 6, :date => 5.days.ago
    create :stock_transaction, :stock => stock1, :portfolio => portfolio, :quantity => 4, :price => 5, :date => Date.today, :action => "sell"

    subject.stocks_positions_profit_or_loss.should include(*[[stock.name, "12.00" ], [stock1.name, "-4.00"]])
  end

  it "should have catogorywise mf percentages" do
    subject
    scheme2 = create :scheme_master_with_navcp, :scheme_class_description => "BAR"
    create :mutual_fund_transaction, :mutual_fund => create( :mutual_fund, :name => scheme2.scheme_name), :portfolio => portfolio, :quantity => 4, :price => 6, :date => Date.today
    subject.category_wise_mutual_funds_percentage.should include(*[["FOO", 71.43], ["BAR", 28.57]])
  end

  it "should have mutual fund sell positions" do
    subject
    create :mutual_fund_transaction, :mutual_fund => create( :mutual_fund, :name => scheme.scheme_name), :portfolio => portfolio, :quantity => 4, :price => 6, :date => Date.today, :action => "sell"
    scheme2 = create :scheme_master, :scheme_class_description => "BAR"
    create :mutual_fund_transaction, :mutual_fund => create(:mutual_fund, :name => scheme2.scheme_name), :portfolio => portfolio, :quantity => 1, :price => 5, :date => 2.days.ago
    create :mutual_fund_transaction, :mutual_fund => create(:mutual_fund, :name => scheme2.scheme_name), :portfolio => portfolio, :quantity => 1, :price => 4, :date => 1.days.ago, :action => "sell"

    subject.mutual_fund_positions_profit_or_loss.should include(*[[ scheme.scheme_name, "12.00" ],[ scheme2.scheme_name, "-1.00"]] )
  end

  it "should have fixed deposit open positions rate of interests" do
    subject
    fixed_deposit2 = create :fixed_deposit, :name => "BAR", :period => 5, :rate_of_interest => 12.0
    create :fixed_deposit_transaction, :fixed_deposit => fixed_deposit2, :portfolio => portfolio, :price => 1000, :date => 5.months.ago.to_date
    subject.fixed_deposit_open_positions_rate_of_interests.should include(*[[10.0, 100], [12.0, 1000]])
  end

  it "should give top five profits" do
    subject
    create_sell_position_of_all_securities_type
    expected = [["Test Property", "400.00"], [stock.name, "12.00"], [scheme.scheme_name, "12.00"], ["Foo", "4.64"]]
    subject.top_five_profits.should include *expected
  end

  it "should give top five losses" do
    subject
    create_sell_position_of_all_securities_type
    expected = [["Test Property2", "-400.00"], ["FOO", "-4.00"], ["Foo Scheme Name", "-1.00"]]
    subject.top_five_losses.should include *expected
  end

  def create_securities
    scrip = create :scrip, :last_traded_price => 5, :id => stock.symbol
    4.times { |n| create :stock_transaction, :stock => stock, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    navcp  = create :navcp, :nav_amount => "5", :security_code => scheme.securitycode
    4.times { |n| create :mutual_fund_transaction, :mutual_fund => create(:mutual_fund, :name => scheme.scheme_name), :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    gold = create :gold, :name => "Gold", :current_price => 5
    4.times { |n| create :gold_transaction, :gold => gold, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    loan =  create :loan, :name => "Foo Loan", :rate_of_interest => "10", :period => "1"
    loan_transaction =  create :loan_transaction, :loan => loan, :price => -1000, :date => 8.months.ago.to_date, :portfolio => portfolio

    fixed_deposit = create :fixed_deposit, :name => "Foo", :period => 5, :rate_of_interest => 10.0
    create :fixed_deposit_transaction, :fixed_deposit => fixed_deposit, :portfolio => portfolio, :price => 100, :date => 8.months.ago.to_date

    create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 500, :date => Date.civil(2011, 12, 01), :action => "buy"
  end

  def create_sell_position_of_all_securities_type
    create :stock_transaction, :stock => stock, :portfolio => portfolio, :quantity => 4, :price => 6, :date => Date.today, :action => "sell"
    stock1 = create :stock_with_scrip, :sector => "BAR", :name => "FOO"
    create :stock_transaction, :stock => stock1, :portfolio => portfolio, :quantity => 4, :price => 6, :date => 5.days.ago
    create :stock_transaction, :stock => stock1, :portfolio => portfolio, :quantity => 4, :price => 5, :date => Date.today, :action => "sell"

    create :mutual_fund_transaction, :mutual_fund => create( :mutual_fund, :name => scheme.scheme_name), :portfolio => portfolio, :quantity => 4, :price => 6, :date => Date.today, :action => "sell"
    scheme2 = create :scheme_master, :scheme_class_description => "BAR", :scheme_name => "Foo Scheme Name"
    create :mutual_fund_transaction, :mutual_fund => create(:mutual_fund, :name => scheme2.scheme_name), :portfolio => portfolio, :quantity => 1, :price => 5, :date => 2.days.ago
    create :mutual_fund_transaction, :mutual_fund => create(:mutual_fund, :name => scheme2.scheme_name), :portfolio => portfolio, :quantity => 1, :price => 4, :date => 1.days.ago, :action => "sell"

    fixed_deposit = create :fixed_deposit, :name => "Foo", :period => 5, :rate_of_interest => 8.0
    create :fixed_deposit_transaction, :fixed_deposit => fixed_deposit, :portfolio => portfolio, :price => 100, :date => 1.months.ago.to_date, :action => "sell"

    create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 900, :date => Date.civil(2012, 2, 01), :action => "sell"
    real_estate_2 = create :real_estate, :name => "Test Property2", :location => "Mordor", :current_price => 500
    create :real_estate_transaction, :real_estate => real_estate_2, :portfolio => portfolio, :price => 900, :date => Date.civil(2011, 12, 01)
    create :real_estate_transaction, :real_estate => real_estate_2, :portfolio => portfolio, :price => 500, :date => Date.civil(2012, 01, 01), :action => "sell"
  end
end
