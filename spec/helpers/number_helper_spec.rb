require 'spec_helper'

describe NumberHelper do
  it "should delimit numbers by comma in indian format" do
    helper.number_to_indian_currency(12000).should eq "12,000.00"
  end

  it "should format number to two precision" do
    helper.number_to_indian_currency(0).should eq "0.00"
  end

  it "should convert NaN to zero" do
    number = 0.0 / 0.0
    helper.number_to_indian_currency(number).should eq "0.00"
  end

  it "should convert 'nil' value to zero" do
    number = nil
    helper.number_to_indian_currency(number).should eq "0.00"
  end
end
