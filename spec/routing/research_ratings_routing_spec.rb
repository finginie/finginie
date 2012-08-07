require "spec_helper"

describe ResearchRatingsController do
  describe "routing" do

    it "routes to #index" do
      get("/research_ratings").should route_to("research_ratings#index")
    end

    it "routes to #new" do
      get("/research_ratings/new").should route_to("research_ratings#new")
    end

    it "routes to #show" do
      get("/research_ratings/1").should route_to("research_ratings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/research_ratings/1/edit").should route_to("research_ratings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/research_ratings").should route_to("research_ratings#create")
    end

    it "routes to #update" do
      put("/research_ratings/1").should route_to("research_ratings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/research_ratings/1").should route_to("research_ratings#destroy", :id => "1")
    end

  end
end
