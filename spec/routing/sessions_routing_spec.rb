require "spec_helper"

describe SessionsController do
  describe "routing" do
    it "routes to #new" do
      get("/signin").should route_to("sessions#new")
    end

    it "routes to #create" do
      post("/auth/facebook/callback").should route_to("sessions#create", :provider => 'facebook')
    end

    it "routes to #destroy" do
      delete("/signout").should route_to("sessions#destroy")
    end
  end
end