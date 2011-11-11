require 'spec_helper'

describe MonthlySipCalculator do
  it "should calculate the right monthly sip" do
    MonthlySipCalculator.new(
      :financial_goal        => 1000000,
      :rate_of_return        => 11,
      :no_months             => 24
    ).monthly_sip.should eq 37101.08

    MonthlySipCalculator.new(
      :financial_goal        => 3000000,
      :rate_of_return        => 14,
      :no_months             => 36
    ).monthly_sip.should eq 66754.09

    MonthlySipCalculator.new(
      :financial_goal        => 500000,
      :rate_of_return        => 11.25,
      :no_months             => 60
    ).monthly_sip.should eq 6188.14

    MonthlySipCalculator.new(
      :financial_goal        => 5000000,
      :rate_of_return        => 9.75,
      :no_months             => 72
    ).monthly_sip.should eq 50961.02
   end
end
