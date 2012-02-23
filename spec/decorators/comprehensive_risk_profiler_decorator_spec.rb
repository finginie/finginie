require 'spec_helper'

describe ComprehensiveRiskProfilerDecorator do
  before { ApplicationController.new.set_current_view_context }

  let(:comprehensive_risk_profiler) { create :comprehensive_risk_profiler,
    :age                      => 30,
    :household_savings        => 200000,
    :household_income         => 60000,
    :household_expenditure    => 35000,
    :dependent                => 3,
    :portfolio_investment     => 5,
    :tax_saving_investment    => 100,
    :special_goals_amount     => 2500000,
    :special_goals_years      => 5,
    :preference               => 6,
    :time_horizon             => 4
  }

  let (:comprehensive_risk_profiler_decorator) { ComprehensiveRiskProfilerDecorator.decorate comprehensive_risk_profiler }

  subject { comprehensive_risk_profiler_decorator }

  its(:age_summary) { should eq I18n.t "age_summary.below_thirty_five" }

  its(:time_horizon_summary) { should eq I18n.t "time_horizon_summary.below_five_years", :time_horizon_years => comprehensive_risk_profiler_decorator.time_horizon }

  its(:special_goals_summary) { should eq I18n.t "special_goals_summary.condition_false", :monthly_savings_needed => comprehensive_risk_profiler_decorator.monthly_savings_needed }

  its(:score_view_summary) { should eq I18n.t "score_summary.below_eight" }

  its(:inadequate_household_income) { should eq nil }

  its(:inadequate_household_savings) { should eq nil }

  its(:initial_investment) { should eq "1,30,000" }

  its(:monthly_savings_needed) { should eq 4826 }

  its(:three_month_investment_amount) { should eq "75,000" }

  its(:three_month_household_expenditure) { should eq "1,05,000" }

  its(:summary) { should_not include "translation missing" }

  it "should get view summary for household savings" do
    comprehensive_risk_profiler_decorator.update_attributes(:household_income => 30000, :household_savings => 100000, :household_expenditure => 45000)
    comprehensive_risk_profiler_decorator.inadequate_household_income.should eq I18n.t "household_savings_summary.inadequate_household_income"
    comprehensive_risk_profiler_decorator.inadequate_household_savings.should eq I18n.t "household_savings_summary.inadequate_household_savings", :household_savings_less_amount => comprehensive_risk_profiler_decorator.three_month_household_expenditure
  end
end