require 'spec_helper'

describe EmiCalculator do
  it "should calculate the right emi" do
    EmiCalculator.new(
      :cost         => 400000,
      :down_payment => 100000,
      :rate         => 12.5,
      :term         => 5
    ).calculate_emi.should eq 6749.38

    EmiCalculator.new(
      :cost         => 2500000,
      :down_payment => 500000,
      :rate         => 10.5,
      :term         => 5
    ).calculate_emi.should eq 42987.8

    EmiCalculator.new(
      :cost         => 4500000,
      :down_payment => 500000,
      :rate         => 13,
      :term         => 10
    ).calculate_emi.should eq 59724.3

    EmiCalculator.new(
      :cost         => 6000000,
      :down_payment => 0,
      :rate         => 12.75,
      :term         => 20
    ).calculate_emi.should eq 69228.7

  end
end
