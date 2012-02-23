require 'spec_helper'

describe "Authentication" do
  it "should sign in using facebook" do
    visit '/auth/facebook'
    page.should have_content 'Successfully signed in'
  end

  it "should sign in using gmail" do
    visit '/auth/google_oauth2'
    page.should have_content 'Successfully signed in'
  end

  context "while logged in" do
    include_context "logged in user"

    it "should logout and go to homepage when the user signed out" do
      visit root_path
      click_button 'Sign out'
      current_path.should eq root_path
      page.should have_content 'Successfully signed out'
    end
  end

  it "should redirect to signin page for the pages requiring authentication" do
    visit portfolios_path
    current_path.should eq signin_path
  end

  it "should go back to previous page after logging in" do
    visit portfolios_path
    within "#main" do
      click_button 'Facebook'
    end
    current_path.should eq portfolios_path
  end

  context "New user with existing comprehensive risk profiler" do
    let(:comprehensive_risk_profile) { build :comprehensive_risk_profiler }
    before(:each) { answer_comprehensive_risk_profiler_with(comprehensive_risk_profile) }

    let(:user) { build :user }
    let(:authentication) { build :authentication, :user => user}

    it "should save the risk profiler after signing in" do

      OmniAuth.config.add_mock authentication.provider, { :uid => authentication.uid }

      within "#sign_up" do
        click_button "Facebook"
      end

      page.should have_content 'Successfully signed in'

      visit comprehensive_risk_profiler_path
      page.should have_content "Your Risk Appetite is : #{comprehensive_risk_profile.score.round}"
    end

    def answer_comprehensive_risk_profiler_with(comprehensive_risk_profile)
      visit edit_comprehensive_risk_profiler_path

      fill_in "What is your age?",                             :with => comprehensive_risk_profile.age
      fill_in "What is your current total household savings?", :with => comprehensive_risk_profile.household_savings
      fill_in "What is your monthly household income?",        :with => comprehensive_risk_profile.household_income
      fill_in "How many people are dependent on you?",         :with => comprehensive_risk_profile.dependent
      fill_in "What is your monthly household expenditure?",   :with => comprehensive_risk_profile.household_expenditure

      choose  "comprehensive_risk_profiler_preference_#{comprehensive_risk_profile.preference}"
      choose  "comprehensive_risk_profiler_portfolio_investment_#{comprehensive_risk_profile.portfolio_investment}"

      fill_in "What is the time horizon for your investment? (No. of years)", :with => comprehensive_risk_profile.time_horizon

      click_button 'Submit'
    end
  end
end
