require "spec_helper"

describe LoanTransactionsController do
  describe "routing" do

    it "routes to #index" do
      get("/portfolios/1/loan_transactions").should route_to("loan_transactions#index", :portfolio_id => "1")
    end

    it "routes to #new" do
      get("/portfolios/1/loan_transactions/new").should route_to("loan_transactions#new", :portfolio_id => "1")
    end

    it "routes to #show" do
      get("/portfolios/1/loan_transactions/1").should route_to("loan_transactions#show", :id => "1", :portfolio_id => "1")
    end

    it "routes to #edit" do
      get("/portfolios/1/loan_transactions/1/edit").should route_to("loan_transactions#edit", :id => "1", :portfolio_id => "1")
    end

    it "routes to #create" do
      post("/portfolios/1/loan_transactions").should route_to("loan_transactions#create", :portfolio_id => "1")
    end

    it "routes to #update" do
      put("/portfolios/1/loan_transactions/1").should route_to("loan_transactions#update", :id => "1", :portfolio_id => "1")
    end

    it "routes to #destroy" do
      delete("/portfolios/1/loan_transactions/1").should route_to("loan_transactions#destroy", :id => "1", :portfolio_id => "1")
    end

    it "routes to #clear" do
      post("/portfolios/1/loan_transactions/1/clear").should route_to("loan_transactions#clear", :id => "1", :portfolio_id => "1")
    end
  end
end
