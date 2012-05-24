require "spec_helper"

describe FixedDepositsController do
  describe "routing" do

    it "routes to #index" do
      get("/fixed_deposits").should route_to("fixed_deposits#index")
    end
  end
end
