require 'spec_helper'

describe "RiskProfilers" do
  let (:quiz) do
    create :quiz, :name => 'Lorem Ipsum', :result_type => 'mean',
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
  end

  login_user

  it "should show and save the page",:js => true do
    visit financial_planner_risk_profiler_path(:id => quiz.slug)
    page.should have_content 'Lorem Ipsum'

    choose 'Choice 1'
    choose 'Choice 3'

    click_button 'Submit'
    page.should have_content 'successfully'
  end
end
