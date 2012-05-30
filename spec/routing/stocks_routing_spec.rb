require "spec_helper"

describe StocksController do
  describe "routing" do

    it "routes to #index" do
      get("/shares").should route_to("stocks#index")
    end

    it "routes to #screener" do
      get("/shares/screener").should route_to("stocks#screener")
    end

    it "routes to #show" do
      get("/shares/name.").should route_to("stocks#show", :id => "name.")
    end

  end
end
