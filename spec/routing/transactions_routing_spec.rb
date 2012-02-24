require "spec_helper"

describe TransactionsController do
  describe "routing" do

    it "routes to #new" do
      get("/portfolios/1/net_positions/1/transactions/new").should route_to("transactions#new", :portfolio_id => "1", :net_position_id => "1")
    end

    it "routes to #edit" do
      get("/portfolios/1/net_positions/1/transactions/1/edit").should route_to("transactions#edit", :id => "1", :portfolio_id => "1", :net_position_id => "1")
    end

    it "routes to #create" do
      post("/portfolios/1/net_positions/1/transactions").should route_to("transactions#create", :portfolio_id => "1", :net_position_id => "1")
    end

    it "routes to #update" do
      put("/portfolios/1/net_positions/1/transactions/1").should route_to("transactions#update", :id => "1", :portfolio_id => "1", :net_position_id => "1")
    end

    it "routes to #destroy" do
      delete("/portfolios/1/net_positions/1/transactions/1").should route_to("transactions#destroy", :id => "1", :portfolio_id => "1", :net_position_id => "1")
    end
  end
end
