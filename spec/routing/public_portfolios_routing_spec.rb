require "spec_helper"

describe PublicPortfoliosController do
  describe "routing" do

    pending "routes to #index" do
      get("/public_portfolios").should route_to("public_portfolios#index")
    end

    it "routes to #show" do
      get("/public_portfolios/1").should route_to("public_portfolios#show", :id => "1")
    end

    it "routes to #new" do
      get("/public_portfolios/new").should route_to("public_portfolios#new")
    end

    it "routes to #create" do
      post("/public_portfolios/1").should route_to("public_portfolios#create", :id => '1')
    end

    pending "routes to #destroy" do
      delete("/public_portfolios/1").should route_to("public_portfolios#destroy", :id => "1")
    end

    pending "routes to #current_holdings" do
      get("/public_portfolios/1/current_holdings").should route_to("public_portfolios#current_holdings", :id => "1")
    end

    pending "routes to #transactions" do
      get("/public_portfolios/1/historical_transactions").should route_to("public_portfolios#historical_transactions", :id => "1")
    end

    pending "routes to #profpendings" do
      get("/public_portfolios/1/profpending_loss_statement").should route_to("public_portfolios#profpending_loss_statement", :id => "1")
    end
  end
end
