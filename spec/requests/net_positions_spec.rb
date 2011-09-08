require 'spec_helper'

describe "NetPositions" do
  describe "GET /portfolios/1/net_positions" do
    let (:portfolio) { create :portfolio }
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get portfolio_net_positions_path(portfolio)
      response.status.should be(200)
    end
  end
end
