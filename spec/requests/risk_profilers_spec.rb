require 'spec_helper'

describe "RiskProfilers" do
  let (:quiz) do
    create :quiz, :name => 'Lorem Ipsum',
                  :questions => [
                    create(:question, :choices => [
                      create(:choice, :text => "Choice 0"),
                      create(:choice, :text => "Choice 1")
                    ]),
                    create(:question, :choices => [
                      create(:choice, :text => "Choice 2"),
                      create(:choice, :text => "Choice 3")
                    ])
                  ]
  end

  login_user

  it "should show the page" do
    visit risk_profile_risk_profiler_path(:id => quiz.slug)
    page.should have_content 'Lorem Ipsum'

    choose 'Choice 0'
    choose 'Choice 3'

    click_button 'Submit'
  end
end
