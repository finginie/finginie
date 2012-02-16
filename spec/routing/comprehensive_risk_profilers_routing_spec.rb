require "spec_helper"

describe ComprehensiveRiskProfilersController do
  describe "routing" do

    it "routes to #show" do
      get("/comprehensive_risk_profiler").should route_to("comprehensive_risk_profilers#show")
    end

    it "routes to #edit" do
      get("/comprehensive_risk_profiler/edit").should route_to("comprehensive_risk_profilers#edit")
    end

    it "routes to #update" do
      put("/comprehensive_risk_profiler").should route_to("comprehensive_risk_profilers#update")
    end
  end
end
