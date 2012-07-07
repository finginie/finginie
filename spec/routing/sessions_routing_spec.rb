require "spec_helper"

describe SessionsController do
  describe "routing" do
    it "routes to #new" do
      get("/signin").should route_to("sessions#new")
    end

    it "routes to #success" do
      get("/success").should route_to("sessions#success")
    end
  end
end
