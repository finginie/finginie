require "spec_helper"

describe OtherLiabilitiesController do
  describe "routing" do

    it "routes to #index" do
      get("/other_liabilities").should route_to("other_liabilities#index")
    end

    it "routes to #new" do
      get("/other_liabilities/new").should route_to("other_liabilities#new")
    end

    it "routes to #show" do
      get("/other_liabilities/1").should route_to("other_liabilities#show", :id => "1")
    end

    it "routes to #edit" do
      get("/other_liabilities/1/edit").should route_to("other_liabilities#edit", :id => "1")
    end

    it "routes to #create" do
      post("/other_liabilities").should route_to("other_liabilities#create")
    end

    it "routes to #update" do
      put("/other_liabilities/1").should route_to("other_liabilities#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/other_liabilities/1").should route_to("other_liabilities#destroy", :id => "1")
    end

  end
end
