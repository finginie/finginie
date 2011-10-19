require 'spec_helper'

describe "RiskProfilers" do
  let (:quiz) { create :quiz, :name => 'Lorem Ipsum' }
  login_user

  it "should show the page" do
    visit risk_profile_risk_profiler_path(:id => quiz.slug)
    page.should have_content 'Lorem Ipsum'
  end
end
