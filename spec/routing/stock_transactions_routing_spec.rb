require "spec_helper"

describe StockTransactionsController do
  describe "routing" do

    it "routes to #index" do
      get("/portfolios/1/stock_transactions").should route_to("stock_transactions#index", :portfolio_id => "1")
    end

    it "routes to #new" do
      get("/portfolios/1/stock_transactions/new").should route_to("stock_transactions#new", :portfolio_id => "1")
    end

    it "routes to #show" do
      get("/portfolios/1/stock_transactions/1").should route_to("stock_transactions#show", :id => "1", :portfolio_id => "1")
    end

    it "routes to #edit" do
      get("/portfolios/1/stock_transactions/1/edit").should route_to("stock_transactions#edit", :id => "1", :portfolio_id => "1")
    end

    it "routes to #create" do
      post("/portfolios/1/stock_transactions").should route_to("stock_transactions#create", :portfolio_id => "1")
    end

    it "routes to #update" do
      put("/portfolios/1/stock_transactions/1").should route_to("stock_transactions#update", :id => "1", :portfolio_id => "1")
    end

    it "routes to #destroy" do
      delete("/portfolios/1/stock_transactions/1").should route_to("stock_transactions#destroy", :id => "1", :portfolio_id => "1")
    end

  end
end
