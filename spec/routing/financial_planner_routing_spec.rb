require "spec_helper"

describe FinancialPlannerController do
  describe "routing" do
    it "routes to #show" do
      get("/financial_planner").should route_to("financial_planner#show")
    end
  end
end
