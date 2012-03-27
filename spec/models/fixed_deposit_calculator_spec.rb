require 'spec_helper'

describe FixedDepositCalculator do
  it { should validate_presence_of :amount_invested }
  it { should validate_numericality_of :amount_invested }
  it { should_not allow_value(0).for :amount_invested }
  it { should validate_presence_of :rate_of_return }
  it { should validate_numericality_of :rate_of_return }
  it { should_not allow_value(0).for :rate_of_return }
  it { should validate_presence_of :no_months }
  it { should validate_numericality_of :no_months }
  it { should_not allow_value(0).for :no_months }
  it { should validate_presence_of :compounding_frequency }
  it { [1, 3, 6, 12].each {|value| should allow_value(value).for :compounding_frequency } }
  it { should_not allow_value(9).for :compounding_frequency }

  it "should calculate the right fix deposit maturity amount" do
    FixedDepositCalculator.new(
      :amount_invested     => 10000,
      :rate_of_return      => 8.75,
      :no_months           => 12,
      :compounding_frequency   => 3
    ).maturity_amount.should eq 10904.13

    FixedDepositCalculator.new(
      :amount_invested     => 15000,
      :rate_of_return      => 9,
      :no_months           => 24,
      :compounding_frequency   => 3
    ).maturity_amount.should eq 17922.47

    FixedDepositCalculator.new(
      :amount_invested     => 20000,
      :rate_of_return      => 9.25,
      :no_months           => 37,
      :compounding_frequency   => 3
    ).maturity_amount.should eq 26514.53

    FixedDepositCalculator.new(
      :amount_invested     => 25000,
      :rate_of_return      => 9.75,
      :no_months           => 43,
      :compounding_frequency   => 3
    ).maturity_amount.should eq 35306.28
  end
end
