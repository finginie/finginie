require 'spec_helper'

describe SipCalculator do
  it "should calculate the right sip" do
    SipCalculator.new(
      :initial_investment => 1,
      :monthly_amount => 2000,
      :no_months => 12,
      :rate_of_return => 10
    ).calculate_sip.should eq 25341.67

    SipCalculator.new(
      :initial_investment => 1,
      :monthly_amount => 5000,
      :no_months => 24,
      :rate_of_return => 14.5
    ).calculate_sip.should eq 139922.9

    SipCalculator.new(
      :initial_investment => 1,
      :monthly_amount => 7000,
      :no_months => 48,
      :rate_of_return => 13
    ).calculate_sip.should eq 442402.67

  end
end
