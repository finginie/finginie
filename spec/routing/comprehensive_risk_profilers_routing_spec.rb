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

    it "routes to #public" do
      get('/comprehensive_risk_profiler/1/public/').should route_to("comprehensive_risk_profilers#public", :id => '1')
    end
  end
end
