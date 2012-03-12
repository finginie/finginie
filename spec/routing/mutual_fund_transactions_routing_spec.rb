require "spec_helper"

describe MutualFundTransactionsController do
  describe "routing" do

    it "routes to #index" do
      get("/portfolios/1/mutual_fund_transactions").should route_to("mutual_fund_transactions#index", :portfolio_id => "1")
    end

    it "routes to #new" do
      get("/portfolios/1/mutual_fund_transactions/new").should route_to("mutual_fund_transactions#new", :portfolio_id => "1")
    end

    it "routes to #show" do
      get("/portfolios/1/mutual_fund_transactions/1").should route_to("mutual_fund_transactions#show", :id => "1", :portfolio_id => "1")
    end

    it "routes to #edit" do
      get("/portfolios/1/mutual_fund_transactions/1/edit").should route_to("mutual_fund_transactions#edit", :id => "1", :portfolio_id => "1")
    end

    it "routes to #create" do
      post("/portfolios/1/mutual_fund_transactions").should route_to("mutual_fund_transactions#create", :portfolio_id => "1")
    end

    it "routes to #update" do
      put("/portfolios/1/mutual_fund_transactions/1").should route_to("mutual_fund_transactions#update", :id => "1", :portfolio_id => "1")
    end

    it "routes to #destroy" do
      delete("/portfolios/1/mutual_fund_transactions/1").should route_to("mutual_fund_transactions#destroy", :id => "1", :portfolio_id => "1")
    end

  end
end
