require "spec_helper"

describe TradeAccountsController do
  describe "routing" do

    it "routes to #index" do
      get("/trade_accounts").should route_to("trade_accounts#index")
    end

    it "routes to #new" do
      get("/trade_accounts/new").should route_to("trade_accounts#new")
    end

    it "routes to #show" do
      get("/trade_accounts/1").should route_to("trade_accounts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/trade_accounts/1/edit").should route_to("trade_accounts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/trade_accounts").should route_to("trade_accounts#create")
    end

    it "routes to #update" do
      put("/trade_accounts/1").should route_to("trade_accounts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/trade_accounts/1").should route_to("trade_accounts#destroy", :id => "1")
    end

  end
end
