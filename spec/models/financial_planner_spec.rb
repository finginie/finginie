require 'spec_helper'

describe FinancialPlanner do

  let(:financial_planner) {create :financial_planner}

  subject {financial_planner}
  it { should have_many :risk_profilers}
  it { should validate_numericality_of :willingness_to_take_risk }
  its(:willingness_to_take_risk) { should eq 10 }

  it "should build risk_profilers for a given quiz" do
    3.times { |i| create :quiz, :name => "quiz_#{i}"}
    financial_planner.build_risk_profilers

    financial_planner.risk_profilers.size.should eq 3
  end

  it "should calculate the overall_risk_tolerance for given risk_profilers" do
    2.times { |i| create :risk_profiler, :score => i+3, :financial_planner_id => financial_planner.id, :quiz => (
              create :quiz,:name => "fin_planner_quiz#{i}", :weight => 4+i, :number_of_questions => 2, :number_of_choices_per_question => 3) }

    financial_planner.overall_risk_tolerance.round(1).to_f.should eq 3.6
  end

end
