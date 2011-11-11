require 'spec_helper'

describe RecurringDepositCalculator do
  it "should calculate the right Recurring Deposit" do
    RecurringDepositCalculator.new(
      :amount_deposit             => 20000,
      :rate_of_return             => 9.25,
      :no_months                  => 12,
      :interest_compound          => 'Quarterly'
    ).maturity_amount.should eq 252274.69

    RecurringDepositCalculator.new(
      :amount_deposit             => 10000,
      :rate_of_return             => 10.75,
      :no_months                  => 24,
      :interest_compound          => 'Quarterly'
    ).maturity_amount.should eq 268543.08

    RecurringDepositCalculator.new(
      :amount_deposit             => 15000,
      :rate_of_return             => 10,
      :no_months                  => 36,
      :interest_compound          => 'Quarterly'
    ).maturity_amount.should eq 631118.16

    RecurringDepositCalculator.new(
      :amount_deposit             => 25000,
      :rate_of_return             => 10.25,
      :no_months                  => 48,
      :interest_compound          => 'Quarterly'
    ).maturity_amount.should eq 1485531.45

    RecurringDepositCalculator.new(
      :amount_deposit             => 50000,
      :rate_of_return             => 14,
      :no_months                  => 48,
      :interest_compound          => 'Monthly'
    ).maturity_amount.should eq 3230137.14

  end
end
