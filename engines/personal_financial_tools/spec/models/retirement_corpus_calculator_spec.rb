require 'spec_helper'

describe RetirementCorpusCalculator do
  it "should calculate the right retirement corpus ex: #1" do
    RetirementCorpusCalculator.new(
      :current_age          => 42,
      :retirement_age       => 60,
      :monthly_expenses     => 15000,
      :inflation            => 6,
      :expected_return      => 9
    ).monthly_savings.should eq 14776.67
  end

  it "should calculate the right retirement corpus ex: #2" do
    RetirementCorpusCalculator.new(
      :current_age          => 45,
      :retirement_age       => 60,
      :monthly_expenses     => 13000,
      :inflation            => 9,
      :expected_return      => 11
    ).monthly_savings.should eq 20952.79
  end

  it "should calculate the right retirement corpus ex: #3" do
    RetirementCorpusCalculator.new(
      :current_age          => 42,
      :retirement_age       => 60,
      :monthly_expenses     => 18000,
      :inflation            => 5,
      :expected_return      => 8.75
    ).monthly_savings.should eq 14470.6
  end

  it "should calculate the right retirement corpus ex: #4" do
    RetirementCorpusCalculator.new(
      :current_age          => 36,
      :retirement_age       => 58,
      :monthly_expenses     => 15000,
      :inflation            => 7,
      :expected_return      => 9.25
    ).monthly_savings.should eq 16503.6
  end
end
