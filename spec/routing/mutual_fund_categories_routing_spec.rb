require "spec_helper"

describe MutualFundCategoriesController do
  describe "routing" do

    it "routes to #show" do
      get("/mutual_fund_categories/1").should route_to("mutual_fund_categories#show", :id => "1")
    end
  end
end
