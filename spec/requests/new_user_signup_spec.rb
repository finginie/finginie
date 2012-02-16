require 'spec_helper'

describe "New User" do
  it "should be taken to tutorial and right from home page" do
    visit root_url
    click_link "Get Started"
    current_path.should eq page_path('basic_tutorial')
    page.should have_content "Basic Tutorial"
  end

  it "should be taken to comprehensive quiz page" do
    visit page_path('basic_tutorial')
    click_link "Ideal Asset Allocation"
    current_path.should eq edit_comprehensive_risk_profiler_path
  end
end
