require 'spec_helper'

describe RateOfReturnCalculator do
  it "should calculate the right rate of return " do
    RateOfReturnCalculator.new(
      :initial_investment       => 20000,
      :received_amount          => 40000,
      :no_years                 => 5
    ).calculate_rate_of_return.should eq 14.87

    RateOfReturnCalculator.new(
      :initial_investment       => 240000,
      :received_amount          => 500000,
      :no_years                 => 2
    ).calculate_rate_of_return.should eq 44.34

    RateOfReturnCalculator.new(
      :initial_investment       => 1000000,
      :received_amount          => 1500000,
      :no_years                 => 4
    ).calculate_rate_of_return.should eq 10.67

    RateOfReturnCalculator.new(
      :initial_investment       => 500000,
      :received_amount          => 700000,
      :no_years                 => 5
    ).calculate_rate_of_return.should eq 6.96

  end
end
