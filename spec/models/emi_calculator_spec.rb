require 'spec_helper'

describe EmiCalculator do
  it "should calculate the right emi" do
    EmiCalculator.new(:cost => 1500000, :down_payment => 500000, :rate => 12.5,   :term => 15 ).emi.should eq 12325
    EmiCalculator.new(:cost => 500000,  :down_payment => 100000, :rate => 13.25,  :term => 3  ).emi.should eq 13526
    EmiCalculator.new(:cost => 900000,  :down_payment => 200000, :rate => 11,     :term => 5  ).emi.should eq 15220
    EmiCalculator.new(:cost => 2000000, :down_payment => 500000, :rate => 12.75,  :term => 7  ).emi.should eq 27084
    EmiCalculator.new(:cost => 2600000, :down_payment => 100000, :rate => 14,     :term => 20 ).emi.should eq 31088
  end
end
