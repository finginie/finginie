require "spec_helper"

describe FixedDepositTransactionsController do
  describe "routing" do

    it "routes to #index" do
      get("/portfolios/1/fixed_deposit_transactions").should route_to("fixed_deposit_transactions#index", :portfolio_id => "1")
    end

    it "routes to #new" do
      get("/portfolios/1/fixed_deposit_transactions/new").should route_to("fixed_deposit_transactions#new", :portfolio_id => "1")
    end

    it "routes to #show" do
      get("/portfolios/1/fixed_deposit_transactions/1").should route_to("fixed_deposit_transactions#show", :id => "1", :portfolio_id => "1")
    end

    it "routes to #edit" do
      get("/portfolios/1/fixed_deposit_transactions/1/edit").should route_to("fixed_deposit_transactions#edit", :id => "1", :portfolio_id => "1")
    end

    it "routes to #create" do
      post("/portfolios/1/fixed_deposit_transactions").should route_to("fixed_deposit_transactions#create", :portfolio_id => "1")
    end

    it "routes to #update" do
      put("/portfolios/1/fixed_deposit_transactions/1").should route_to("fixed_deposit_transactions#update", :id => "1", :portfolio_id => "1")
    end

    it "routes to #destroy" do
      delete("/portfolios/1/fixed_deposit_transactions/1").should route_to("fixed_deposit_transactions#destroy", :id => "1", :portfolio_id => "1")
    end

    it "routes to #redeem" do
      get("/portfolios/1/fixed_deposit_transactions/1/redeem").should route_to("fixed_deposit_transactions#redeem", :id => "1", :portfolio_id => "1")
    end

    it "routes to #create_redeem" do
      put("/portfolios/1/fixed_deposit_transactions/1/create_redeem").should route_to("fixed_deposit_transactions#create_redeem", :id => "1", :portfolio_id => "1")
    end
  end
end
