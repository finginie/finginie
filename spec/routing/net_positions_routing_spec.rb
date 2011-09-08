require "spec_helper"

describe NetPositionsController do
  describe "routing" do

    it "routes to #index" do
      get("/portfolios/1/net_positions").should route_to("net_positions#index", :portfolio_id => "1")
    end

    it "routes to #new" do
      get("/portfolios/1/net_positions/new").should route_to("net_positions#new", :portfolio_id => "1")
    end

    it "routes to #show" do
      get("/portfolios/1/net_positions/1").should route_to("net_positions#show", :id => "1", :portfolio_id => "1")
    end

    it "routes to #edit" do
      get("/portfolios/1/net_positions/1/edit").should route_to("net_positions#edit", :id => "1", :portfolio_id => "1")
    end

    it "routes to #create" do
      post("/portfolios/1/net_positions").should route_to("net_positions#create", :portfolio_id => "1")
    end

    it "routes to #update" do
      put("/portfolios/1/net_positions/1").should route_to("net_positions#update", :id => "1", :portfolio_id => "1")
    end

    it "routes to #destroy" do
      delete("/portfolios/1/net_positions/1").should route_to("net_positions#destroy", :id => "1", :portfolio_id => "1")
    end

  end
end
