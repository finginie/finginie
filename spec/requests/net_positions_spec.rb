require 'spec_helper'

describe "NetPositions" do
  describe "GET /net_positions" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get net_positions_path
      response.status.should be(200)
    end
  end
end
