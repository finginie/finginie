require 'spec_helper'

describe "Portfolios" do
  include_context "logged in user"
  let (:portfolio) { create :portfolio, :user => current_user }

  let(:stock) { create :stock }
  let(:scrip) { create :scrip, :last_traded_price => 5, :id => stock.symbol}

  it "should show all net positions in details page" do
    scrip.save
    4.times { |n| create :stock_transaction, :stock => stock, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }
    visit details_portfolio_path(portfolio)

    expected_table = [
                      ["Name", "Quantity", "Average Cost Price", "Market Price", "Amount Invested", "Market Value", "Profit"],
                      [stock.name, "10", "3.0", "5.0", "30.0", "50.0", "20.0"]
                    ]
    tableish("table").should eq expected_table
  end

end
