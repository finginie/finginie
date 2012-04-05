require "spec_helper"

describe StocksController do
  describe "routing" do

    it "routes to #index" do
      get("/stocks").should route_to("stocks#index")
    end

    it "routes to #show" do
      get("/stocks/134567.01").should route_to("stocks#show", :id => "134567.01")
    end

  end
end
