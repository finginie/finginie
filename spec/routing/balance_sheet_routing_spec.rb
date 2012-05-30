require "spec_helper"

describe BalanceSheetController do
  describe "routing" do

    it "routes to #show" do
      get("/shares/company_name/balance_sheet").should route_to("balance_sheet#show", :stock_id => "company_name")
    end
  end
end
