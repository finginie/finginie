require 'spec_helper'

describe "Portfolios" do
  include_context "logged in user"
  let (:portfolio) { create :portfolio, :user => current_user }

  it "groups net positions by asset type" do
    stock_position = create :net_position, :security => create(:stock), :portfolio => portfolio
    create :scrip, :id => stock_position.security.symbol, :last_traded_price => 20
    stock_position.transactions.create build(:transaction, :quantity => 100, :price => 10).attributes
    loan_position = create :net_position, :security => create(:loan, :rate_of_interest => 10, :period => 5), :portfolio => portfolio
    loan_position.transactions.create build(:transaction, :quantity => 100, :price => 10).attributes
    fixed_income_position = create :net_position, :security => create(:fixed_income, :rate_of_interest => 10, :period => 5), :portfolio => portfolio
    fixed_income_position.transactions.create build(:transaction, :quantity => 100, :price => 10).attributes

    visit portfolio_path portfolio
    within "section.Stock table" do
      page.should have_content stock_position.security.name
    end
    within "section.FixedIncome table" do
      page.should have_content fixed_income_position.security.name
    end
    within "section.Loan table" do
      page.should have_content loan_position.security.name
    end
  end

  it "shows stock net positions summary" do
    stock_position = create :net_position, :security => create(:stock, :name => "FOO 1"), :portfolio => portfolio
    create :scrip, :id => stock_position.security.symbol, :last_traded_price => 20
    stock_position.transactions.create build(:transaction, :quantity => 100, :price => 10).attributes
    stock_position.transactions.create build(:transaction, :quantity => 100, :price => 12).attributes

    visit portfolio_path portfolio
    expected_table =[
                      ["Name", "Quantity", "Average Cost Price", "Market Price", "Amount Invested", "Market value", "Profit", ""],
                      ["FOO 1", "200", "11.0", "20.0", "2200.0", "4000", "1800.0", ""]
                    ]
    tableish("section.Stock table").should eq expected_table
  end
end
