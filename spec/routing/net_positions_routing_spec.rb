require "spec_helper"

describe NetPositionsController do
  describe "routing" do

    it "routes to #index" do
      get("/net_positions").should route_to("net_positions#index")
    end

    it "routes to #new" do
      get("/net_positions/new").should route_to("net_positions#new")
    end

    it "routes to #show" do
      get("/net_positions/1").should route_to("net_positions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/net_positions/1/edit").should route_to("net_positions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/net_positions").should route_to("net_positions#create")
    end

    it "routes to #update" do
      put("/net_positions/1").should route_to("net_positions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/net_positions/1").should route_to("net_positions#destroy", :id => "1")
    end

  end
end
