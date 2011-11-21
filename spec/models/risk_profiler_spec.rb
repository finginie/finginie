require 'spec_helper'

describe RiskProfiler do
  let (:quiz) { create :quiz, :result_type => 'mean', :name => 'MeanQuiz', :weight => 2,
                  :questions => [
                    create(:question, :weight => 4,:choices => [
                      create(:choice, :text => "Choice 0", :ceiling => 3, :score => 2),
                      create(:choice, :text => "Choice 1", :ceiling => 2, :score => 3)
                    ]),
                    create(:question, :weight => 3,:choices => [
                      create(:choice, :text => "Choice 2", :ceiling => 5, :score => 3),
                      create(:choice, :text => "Choice 3", :ceiling => 3, :score =>2)
                    ])
                  ]
               }

  let (:risk_profiler) { create :risk_profiler, :quiz => quiz }

  subject { risk_profiler }
  it { should have_many :responses }

  it{ should validate_presence_of :quiz_id }

  it "should build responses for a given quiz" do
    risk_profiler.build_responses

    risk_profiler.responses.size.should eq 2
    risk_profiler.questions.should include *quiz.questions
  end

  it "should not rebuild existing responses" do
    response = create :response, :risk_profiler => risk_profiler, :choice => create(:choice, :question => quiz.questions[1])
    risk_profiler.build_responses

    risk_profiler.questions.should include *quiz.questions
    risk_profiler.responses.size.should eq 2
  end

  it "should save the risk profiler with score for Mean Quiz" do
     [0,1].each { |n| risk_profiler.responses.create(:choice => quiz.questions[n].choices[n]) }
     risk_profiler.save
     risk_profiler.score.should eq 2
  end

  it "should save the risk profiler with score for Mode Quiz" do
     quiz.result_type = 'mode'
     quiz.save

     [0,1].each { |n| risk_profiler.responses.create(:choice => quiz.questions[n].choices[1]) }
     risk_profiler.save
     risk_profiler.score.should eq 3

  end
end
