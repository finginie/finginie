require 'spec_helper'

describe "NetPositions" do
  describe "Add new net position" do
    let (:portfolio) { create :portfolio }
    it "adds new stock position" do
      visit new_portfolio_net_position_path(portfolio)
    end
  end
end
