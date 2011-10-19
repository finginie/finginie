require "spec_helper"

describe RiskProfilersController do
  describe "routing" do

    it "routes to #show" do
      get("/risk_profile/risk_profilers/1").should route_to("risk_profilers#show", :id => "1")
    end

    it "routes to #update" do
      put("/risk_profile/risk_profilers/1").should route_to("risk_profilers#update", :id => "1")
    end

  end
end
