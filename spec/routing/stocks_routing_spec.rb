require "spec_helper"

describe StocksController do
  describe "routing" do

    it "routes to #index" do
      get("/stocks").should route_to("stocks#index")
    end

    it "routes to #show" do
      get("/stocks/1").should route_to("stocks#show", :id => "1")
    end

  end
end
