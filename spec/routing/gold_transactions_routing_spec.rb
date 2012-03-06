require "spec_helper"

describe GoldTransactionsController do
  describe "routing" do

    it "routes to #index" do
      get("/portfolios/1/gold_transactions").should route_to("gold_transactions#index", :portfolio_id => "1")
    end

    it "routes to #new" do
      get("/portfolios/1/gold_transactions/new").should route_to("gold_transactions#new", :portfolio_id => "1")
    end

    it "routes to #show" do
      get("/portfolios/1/gold_transactions/1").should route_to("gold_transactions#show", :id => "1", :portfolio_id => "1")
    end

    it "routes to #edit" do
      get("/portfolios/1/gold_transactions/1/edit").should route_to("gold_transactions#edit", :id => "1", :portfolio_id => "1")
    end

    it "routes to #create" do
      post("/portfolios/1/gold_transactions").should route_to("gold_transactions#create", :portfolio_id => "1")
    end

    it "routes to #update" do
      put("/portfolios/1/gold_transactions/1").should route_to("gold_transactions#update", :id => "1", :portfolio_id => "1")
    end

    it "routes to #destroy" do
      delete("/portfolios/1/gold_transactions/1").should route_to("gold_transactions#destroy", :id => "1", :portfolio_id => "1")
    end

  end
end
