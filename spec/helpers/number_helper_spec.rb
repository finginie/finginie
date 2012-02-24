require 'spec_helper'

describe NumberHelper do
  it "should delimit numbers by comma in indian format" do
    helper.number_to_indian_currency(12000).should eq "12,000"
  end
end
