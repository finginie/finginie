require 'spec_helper'

describe "ResearchRatings" do
  describe "GET /research_ratings" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get research_ratings_path
      response.status.should be(200)
    end
  end
end
