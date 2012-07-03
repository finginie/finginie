require "spec_helper"

describe ResearchReportsController do
  describe "routing" do

    it "routes to #index" do
      get("/research_reports").should route_to("research_reports#index")
    end

    pending "routes to #index with stock id" do
      get("/shares/name/research_reports").should route_to("research_reports#index", :stock_id => "name")
    end

  end
end
