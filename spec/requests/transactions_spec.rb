require 'spec_helper'

describe "Transactions" do
  describe "GET /portfolios/1/net_positions/1/transactions/new" do
    let (:portfolio) { create :portfolio }
    let (:net_position) { create :net_position, :portfolio => portfolio}
  end

  describe "#index" do
    include_context "logged in user"
    let (:portfolio) { create :portfolio, :user => current_user }

    let(:net_position) { create :net_position, :portfolio => portfolio, :security => create(:stock, :name => 'Foo 1') }
    it "should list all transaction of the portfolio" do
      add_stock_position(net_position, 1, 1, Date.civil(2007, 1, 31), :buy)
      add_stock_position(net_position, 1, 1, Date.civil(2007, 3, 31), :sell)

      visit portfolio_transactions_path(portfolio)
      expected_table = [["Date", "Asset Name", "Type", "Action", "Price Per Unit", "Quantity", "Value", "Portfolio Value"],
                        ["2007-01-31", "Foo 1", "Stock", "buy", "1.0", "1", "1.0", "1.0"],
                        ["2007-03-31", "Foo 1", "Stock", "sell", "1.0", "-1", "-1.0", "0.0"]]
      rows = page.find("table").all('tr')
      table = rows.map { |r| r.all('th,td').map { |c| c.text.strip } }
      table.should eq expected_table
    end

    def add_stock_position(stock_position, quantity, price, date, action)
      transaction = create :transaction, :net_position => stock_position, :quantity => quantity, :price => price, :action => action, :date => date
      create :scrip, :id => stock_position.security.symbol
    end
  end
end
