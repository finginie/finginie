require 'spec_helper'

describe FixedDepositCalculator do
  it "should calculate the right fix deposit maturity amount" do
    FixedDepositCalculator.new(
      :amount_invested     => 10000,
      :rate_of_return      => 8.75,
      :no_months           => 12,
      :interest_compound   => 'Quarterly'
    ).maturity_amount.should eq 10904.13

    FixedDepositCalculator.new(
      :amount_invested     => 15000,
      :rate_of_return      => 9,
      :no_months           => 24,
      :interest_compound   => 'Quarterly'
    ).maturity_amount.should eq 17922.47

    FixedDepositCalculator.new(
      :amount_invested     => 20000,
      :rate_of_return      => 9.25,
      :no_months           => 37,
      :interest_compound   => 'Quarterly'
    ).maturity_amount.should eq 26514.53

    FixedDepositCalculator.new(
      :amount_invested     => 25000,
      :rate_of_return      => 9.75,
      :no_months           => 43,
      :interest_compound   => 'Quarterly'
    ).maturity_amount.should eq 35306.28
  end
end
