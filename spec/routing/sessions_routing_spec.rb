require "spec_helper"

describe SessionsController do
  describe "routing" do
    it "routes to #new" do
      get("/signin").should route_to("sessions#new")
    end

    it "routes to #create" do
      post("/auth/finginie/callback").should route_to("sessions#create", :provider => 'finginie')
    end
  end
end
