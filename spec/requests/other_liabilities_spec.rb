require 'spec_helper'

describe "OtherLiabilities" do
  describe "GET /other_liabilities" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get other_liabilities_path
      response.status.should be(200)
    end
  end
end
