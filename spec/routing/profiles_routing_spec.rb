require "spec_helper"

describe ProfilesController do
  describe "routing" do

    it "routes to #index" do
      get("/profiles").should route_to("profiles#index")
    end

    it "routes to #show" do
      get("/profiles/1").should route_to("profiles#show", :id => "1")
    end

    it "routes to #show without id" do
      get("/profile").should route_to("profiles#show")
    end

    it "routes to #edit" do
      get("/profile/edit").should route_to("profiles#edit")
    end

    it "routes to #update" do
      put("/profile").should route_to("profiles#update")
    end

  end
end
