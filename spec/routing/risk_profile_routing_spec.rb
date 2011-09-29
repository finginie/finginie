require "spec_helper"

describe RiskProfileController do
  describe "routing" do
    it "routes to #show" do
      get("/risk_profile").should route_to("risk_profile#show")
    end
  end
end
