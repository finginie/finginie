require "spec_helper"

describe QuizzesController do
  describe "routing" do


    it "routes to #edit" do
      get("/risk_profile/quizzes/1/edit").should route_to("quizzes#edit", :id => "1")
    end

    it "routes to #update" do
      put("/risk_profile/quizzes/1").should route_to("quizzes#update", :id => "1")
    end

  end
end
