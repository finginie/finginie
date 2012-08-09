require "spec_helper"

describe ResearchRatingsController do
  describe "routing" do

    it "routes to #index" do
      get("/research_ratings").should route_to("research_ratings#index")
    end
  end
end
