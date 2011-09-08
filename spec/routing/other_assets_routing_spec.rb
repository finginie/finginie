require "spec_helper"

describe OtherAssetsController do
  describe "routing" do

    it "routes to #index" do
      get("/other_assets").should route_to("other_assets#index")
    end

    it "routes to #new" do
      get("/other_assets/new").should route_to("other_assets#new")
    end

    it "routes to #show" do
      get("/other_assets/1").should route_to("other_assets#show", :id => "1")
    end

    it "routes to #edit" do
      get("/other_assets/1/edit").should route_to("other_assets#edit", :id => "1")
    end

    it "routes to #create" do
      post("/other_assets").should route_to("other_assets#create")
    end

    it "routes to #update" do
      put("/other_assets/1").should route_to("other_assets#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/other_assets/1").should route_to("other_assets#destroy", :id => "1")
    end

  end
end
