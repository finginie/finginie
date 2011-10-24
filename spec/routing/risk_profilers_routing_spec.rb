require "spec_helper"

describe RiskProfilersController do
  describe "routing" do

    it "routes to #show" do
      get("/financial_planner/risk_profilers/1").should route_to("risk_profilers#show", :id => "1")
    end

    it "routes to #update" do
      put("/financial_planner/risk_profilers/1").should route_to("risk_profilers#update", :id => "1")
    end

  end
end
