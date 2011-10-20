require 'spec_helper'

describe RiskProfiler do
  let (:risk_profiler) { create :risk_profiler }
  let (:quiz) { create :quiz, :number_of_questions => 3, :number_of_choices_per_question => 2 }

  subject { risk_profiler }

  it { should have_many :responses }

  it "should build responses for a given quiz" do
    risk_profiler.quiz = quiz
    risk_profiler.build_responses

    risk_profiler.responses.size.should eq 3
    risk_profiler.questions.should include *quiz.questions
  end

  it "should not rebuild existing responses" do
    response = create :response, :risk_profiler => risk_profiler, :choice => create(:choice, :question => quiz.questions[1])
    risk_profiler.quiz = quiz
    risk_profiler.build_responses

    risk_profiler.questions.should include *quiz.questions
    risk_profiler.responses.size.should eq 3
  end
end
