require "spec_helper"

describe RealEstateTransactionsController do
  describe "routing" do

    it "routes to #index" do
      get("/portfolios/1/real_estate_transactions").should route_to("real_estate_transactions#index", :portfolio_id => "1")
    end

    it "routes to #new" do
      get("/portfolios/1/real_estate_transactions/new").should route_to("real_estate_transactions#new", :portfolio_id => "1")
    end

    it "routes to #show" do
      get("/portfolios/1/real_estate_transactions/1").should route_to("real_estate_transactions#show", :id => "1", :portfolio_id => "1")
    end

    it "routes to #edit" do
      get("/portfolios/1/real_estate_transactions/1/edit").should route_to("real_estate_transactions#edit", :id => "1", :portfolio_id => "1")
    end

    it "routes to #create" do
      post("/portfolios/1/real_estate_transactions").should route_to("real_estate_transactions#create", :portfolio_id => "1")
    end

    it "routes to #update" do
      put("/portfolios/1/real_estate_transactions/1").should route_to("real_estate_transactions#update", :id => "1", :portfolio_id => "1")
    end

    it "routes to #destroy" do
      delete("/portfolios/1/real_estate_transactions/1").should route_to("real_estate_transactions#destroy", :id => "1", :portfolio_id => "1")
    end

    it "routes to #sell" do
      get("/portfolios/1/real_estate_transactions/1/sell").should route_to("real_estate_transactions#sell", :id => "1", :portfolio_id => "1")
    end

    it "routes to #create_sell" do
      put("/portfolios/1/real_estate_transactions/1/create_sell").should route_to("real_estate_transactions#create_sell", :id => "1", :portfolio_id => "1")
    end
  end
end
