require 'spec_helper'

describe RetirementCorpusCalculator do
  it "should calculate the right retirement corpus" do
    RetirementCorpusCalculator.new(
      :current_age          => 42,
      :retirement_age       => 60,
      :monthly_expence      => 15000,
      :inflation            => 6,
      :expected_return      => 9
    ).calculate_monthly_return.should eq 14948.55

    RetirementCorpusCalculator.new(
      :current_age          => 45,
      :retirement_age       => 60,
      :monthly_expence      => 13000,
      :inflation            => 9,
      :expected_return      => 0
    ).calculate_monthly_return.should eq 0

    RetirementCorpusCalculator.new(
      :current_age          => 42,
      :retirement_age       => 60,
      :monthly_expence      => 18000,
      :inflation            => 5,
      :expected_return      => 0
    ).calculate_monthly_return.should eq 0

    RetirementCorpusCalculator.new(
      :current_age          => 36,
      :retirement_age       => 58,
      :monthly_expence      => 15000,
      :inflation            => 7,
      :expected_return      => 0
    ).calculate_monthly_return.should eq 0
  end
end
