require 'spec_helper'

describe EmiCalculator do
  it { should validate_presence_of :cost }
  it { should validate_numericality_of :cost }
  it { should_not allow_value(0).for :cost }
  it { should validate_presence_of :rate }
  it { should validate_numericality_of :rate }
  it { should_not allow_value(0).for :rate }
  it { should validate_presence_of :term }
  it { should validate_numericality_of :term }
  it { should_not allow_value(0).for :term }
  it { should validate_numericality_of :down_payment }
  it { should_not allow_value(-1).for :down_payment }

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
