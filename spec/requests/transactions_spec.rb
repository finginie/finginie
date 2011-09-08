require 'spec_helper'

describe "Transactions" do
  describe "GET /portfolios/1/net_positions/1/transactions" do
    let (:portfolio) { create :portfolio }
    let (:net_position) { create :net_position, :portfolio => portfolio}
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get portfolio_net_position_transactions_path(portfolio, net_position)
      response.status.should be(200)
    end
  end
end
