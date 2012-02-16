require 'spec_helper'

describe ComprehensiveRiskProfiler do
  it { should validate_numericality_of :age}
  it { should validate_numericality_of :household_expenditure}
  it { should validate_numericality_of :household_income}
  it { should validate_numericality_of :household_savings}
  it { should validate_numericality_of :time_horizon}
  it { should validate_numericality_of :dependent}
  it { should validate_numericality_of :tax_saving_investment}
  it { should validate_numericality_of :special_goals_years}
  it { should validate_numericality_of :special_goals_amount}
  it { should allow_value(nil).for(:special_goals_amount) }
  it { should allow_value(nil).for(:special_goals_years) }
  it { should allow_value(nil).for(:tax_saving_investment) }
  it { should_not allow_value(-1).for(:age) }
  it { should_not allow_value(-1).for(:household_savings) }
  it { should_not allow_value(-1).for(:household_income) }
  it { should_not allow_value(-1).for(:household_expenditure) }
  it { should_not allow_value(-1).for(:dependent) }
  it { should_not allow_value(-1).for(:time_horizon) }
  it { should_not allow_value(-1).for(:special_goals_amount) }
  it { should_not allow_value(-1).for(:special_goals_years) }
  it { should_not allow_value(-1).for(:tax_saving_investment) }
  it { should ensure_inclusion_of(:preference).in_range(ComprehensiveRiskProfiler::PREFERENCE_OPTIONS) }
  it { should ensure_inclusion_of(:portfolio_investment).in_range(ComprehensiveRiskProfiler::PORTFOLIO_INVESTMENT_OPTIONS) }

  let(:comprehensive_risk_profiler) { create :comprehensive_risk_profiler,
    :age                      => 25,
    :household_savings        => 200000,
    :household_income         => 60000,
    :household_expenditure    => 35000,
    :dependent                => 3,
    :tax_saving_investment    => 100,
    :special_goals_amount     => 2000000,
    :special_goals_years      => 5,
    :preference               => 6,
    :portfolio_investment     => 1,
    :time_horizon             => 4
  }

  subject { comprehensive_risk_profiler }

  it "should calculate score for given comprehensive_risk_profiler and return score 7.62" do
    subject.update_attributes(:age => 30, :household_savings => 200000, :household_income => 60000,
                              :household_expenditure => 35000, :portfolio_investment  => 5)
    subject.score.should eq 7.62
  end

  it "should calculate score for given comprehensive_risk_profiler and return score 5.63" do
    subject.update_attributes(:age => 55, :household_savings => 6000000, :household_income  => 100000,
                              :dependent => 1, :household_expenditure => 20000, :special_goals_amount => 10000000)
    subject.score.should eq 5.63
  end

  it "should calculate score for given comprehensive_risk_profiler and return score 7.05" do
    subject.update_attributes(:age => 40, :household_savings => 1000000, :household_income => 30000,
                              :household_expenditure => 20000, :special_goals_years => 10, :time_horizon => 10)
    subject.score.should eq 7.05
  end

  it "should calculate score for given comprehensive_risk_profiler and return score 9.25" do
    subject.update_attributes(:age => 26, :household_savings => 20000000, :household_income => 150000,
                              :dependent => 0, :household_expenditure => 50000, :special_goals_amount => 25000000,
                              :preference => 10, :portfolio_investment  => 10)
    subject.score.should eq 9.25
  end

  it "should calculate score for given comprehensive_risk_profiler and return score 7.47" do
    subject.update_attributes(:age => 35, :household_savings => 1000000, :household_income  => 40000,
                              :household_expenditure => 20000, :special_goals_amount  => 3000000, :special_goals_years => 10)
    subject.score.should eq 7.47
  end
end
