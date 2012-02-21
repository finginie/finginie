require "spec_helper"

describe MutualFundsController do
  describe "routing" do

    it "routes to #index" do
      get("/mutual_funds").should route_to("mutual_funds#index")
    end

    it "routes to #scheme_summary" do
      get("/mutual_funds/1/scheme_summary").should route_to("mutual_funds#scheme_summary", :id => "1")
    end

     it "routes to #scheme_returns" do
      get("/mutual_funds/1/scheme_returns").should route_to("mutual_funds#scheme_returns", :id => "1")
    end

    it "routes to #top_holdings" do
      get("/mutual_funds/1/top_holdings").should route_to("mutual_funds#top_holdings", :id => "1")
    end

    it "routes to #detailed_holdings" do
      get("/mutual_funds/1/detailed_holdings").should route_to("mutual_funds#detailed_holdings", :id => "1")
    end

    it "routes to #asset_allocation" do
      get("/mutual_funds/1/asset_allocation").should route_to("mutual_funds#asset_allocation", :id => "1")
    end

    it "routes to #sectoral_allocation" do
      get("/mutual_funds/1/sectoral_allocation").should route_to("mutual_funds#sectoral_allocation", :id => "1")
    end

  end
end
