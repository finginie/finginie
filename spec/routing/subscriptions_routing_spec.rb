require "spec_helper"

describe SubscriptionsController do
  describe "routing" do

    it "routes to #index" do
      get("/subscriptions").should route_to("subscriptions#index")
    end

    it "routes to #create" do
      post("/subscriptions").should route_to("subscriptions#create")
    end

    it "routes to #destroy" do
      delete("/subscriptions/1").should route_to("subscriptions#destroy", :id => "1")
    end

  end
end
