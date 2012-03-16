require "spec_helper"

describe PortfoliosController do
  describe "routing" do

    it "routes to #index" do
      get("/portfolios").should route_to("portfolios#index")
    end

    it "routes to #new" do
      get("/portfolios/new").should route_to("portfolios#new")
    end

    it "routes to #show" do
      get("/portfolios/1").should route_to("portfolios#show", :id => "1")
    end

    it "routes to #edit" do
      get("/portfolios/1/edit").should route_to("portfolios#edit", :id => "1")
    end

    it "routes to #create" do
      post("/portfolios").should route_to("portfolios#create")
    end

    it "routes to #update" do
      put("/portfolios/1").should route_to("portfolios#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/portfolios/1").should route_to("portfolios#destroy", :id => "1")
    end

    it "routes to #details" do
      get("/portfolios/1/details").should route_to("portfolios#details", :id => "1")
    end

    it "routes to #transactions" do
      get("/portfolios/1/transactions").should route_to("portfolios#transactions", :id => "1")
    end

    it "routes to #stocks_analysis" do
      get("/portfolios/1/stocks_analysis").should route_to("portfolios#stocks_analysis", :id => "1")
    end

    it "routes to #mutual_funds_analysis" do
      get("/portfolios/1/mutual_funds_analysis").should route_to("portfolios#mutual_funds_analysis", :id => "1")
    end

    it "routes to #fixed_deposits_analysis" do
      get("/portfolios/1/fixed_deposits_analysis").should route_to("portfolios#fixed_deposits_analysis", :id => "1")
    end

    it "routes to #profits" do
      get("/portfolios/1/accumulated_profits").should route_to("portfolios#accumulated_profits", :id => "1")
    end
  end
end
