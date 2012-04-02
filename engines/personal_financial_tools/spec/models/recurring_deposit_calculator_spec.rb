require 'spec_helper'

describe RecurringDepositCalculator do
  it { should validate_presence_of :amount_deposit }
  it { should validate_numericality_of :amount_deposit }
  it { should_not allow_value(0).for :amount_deposit }
  it { should validate_presence_of :rate_of_return }
  it { should validate_numericality_of :rate_of_return }
  it { should_not allow_value(0).for :rate_of_return }
  it { should validate_presence_of :no_months }
  it { should validate_numericality_of :no_months }
  it { should_not allow_value(0).for :no_months }
  it { should validate_presence_of :compounding_frequency }
  it { [1, 3, 6, 12].each {|value| should allow_value(value).for :compounding_frequency } }
  it { should_not allow_value(9).for :compounding_frequency }

  it "should calculate the right Recurring Deposit" do
    RecurringDepositCalculator.new(
      :amount_deposit             => 20000,
      :rate_of_return             => 9.25,
      :no_months                  => 12,
      :compounding_frequency      => 3
    ).maturity_amount.should eq 252274.69

    RecurringDepositCalculator.new(
      :amount_deposit             => 10000,
      :rate_of_return             => 10.75,
      :no_months                  => 24,
      :compounding_frequency      => 3
    ).maturity_amount.should eq 268543.08

    RecurringDepositCalculator.new(
      :amount_deposit             => 15000,
      :rate_of_return             => 10,
      :no_months                  => 36,
      :compounding_frequency      => 3
    ).maturity_amount.should eq 631118.16

    RecurringDepositCalculator.new(
      :amount_deposit             => 25000,
      :rate_of_return             => 10.25,
      :no_months                  => 48,
      :compounding_frequency      => 3
    ).maturity_amount.should eq 1485531.45

    RecurringDepositCalculator.new(
      :amount_deposit             => 50000,
      :rate_of_return             => 14,
      :no_months                  => 48,
      :compounding_frequency      => 1
    ).maturity_amount.should eq 3230137.14

  end
end
