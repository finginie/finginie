require "spec_helper"

describe FixedIncomesController do
  describe "routing" do

    it "routes to #index" do
      get("/fixed_incomes").should route_to("fixed_incomes#index")
    end

    it "routes to #new" do
      get("/fixed_incomes/new").should route_to("fixed_incomes#new")
    end

    it "routes to #show" do
      get("/fixed_incomes/1").should route_to("fixed_incomes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/fixed_incomes/1/edit").should route_to("fixed_incomes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/fixed_incomes").should route_to("fixed_incomes#create")
    end

    it "routes to #update" do
      put("/fixed_incomes/1").should route_to("fixed_incomes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/fixed_incomes/1").should route_to("fixed_incomes#destroy", :id => "1")
    end

  end
end
