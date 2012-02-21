require 'spec_helper'

describe "home page" do
  it "get started should take new user to comprehensive quiz page" do
    visit root_url
    click_link "Get Started"
    current_path.should eq edit_comprehensive_risk_profiler_path
  end
end
