require 'spec_helper'

describe "Authentication" do
  it "should sign in using single_signon oauth2", :js, :omniauth do
    visit '/auth/single_signon'

    page.should have_content 'Successfully signed in'
  end

  it "should redirect to comprehensive_risk_profiler quiz page if user not logged in" do
    visit comprehensive_risk_profiler_ideal_investments_path

    page.current_path.should eq edit_comprehensive_risk_profiler_path
  end

  context "while logged in" do
    include_context "logged in user"

    it "should logout and go to homepage when the user signed out" do
      visit root_path
      click_link 'Sign out'
      current_path.should eq root_path
      page.should have_content 'Successfully signed out'
    end

    it "should go to comprehensive_risk_profiler quiz page if directly clicked on ideal investments link" do
      visit comprehensive_risk_profiler_ideal_investments_path

      page.current_path.should eq edit_comprehensive_risk_profiler_path
    end
  end

  it "should redirect to signin page for the pages requiring authentication" do
    visit portfolios_path
    current_path.should eq signin_path
  end

  it "should go back to previous page after logging in", :js, :omniauth do
    visit portfolios_path

#   omniauth callback url

    current_path.should eq portfolios_path
  end

  context "New user" do
    let(:user) { build :user }

    context "with existing comprehensive risk profiler" do
      let(:comprehensive_risk_profile) { build :comprehensive_risk_profiler }
      before(:each) { answer_comprehensive_risk_profiler_with(comprehensive_risk_profile) }

      it "should save the risk profiler after signing in", :js, :omniauth do

        OmniAuth.config.add_mock 'single_signon', { :uid => user.id }

        visit '/auth/single_signon'

        visit comprehensive_risk_profiler_path
        page.should have_content "Your Risk Appetite is : #{comprehensive_risk_profile.score.round}"
      end
    end

    context "skipped comprehensive risk profiler quiz" do
      it "should save the default score after signing in", :js, :omniauth do
        OmniAuth.config.add_mock 'single_signon', { :uid => user.id }

        visit edit_comprehensive_risk_profiler_path
        find("a#skip_quiz").click

        visit '/auth/single_signon'

        visit comprehensive_risk_profiler_path
        expected_content = [ ['Fixed Deposits', '40%'], [ 'Large Cap Stocks', '20%'], [ 'Mid Cap Stocks', '10%'], [ 'Gold', '30%']]
        tableish("table").should include *expected_content
      end

      it "should go to ideal investments page after signing in", :js, :omniauth do
        OmniAuth.config.add_mock 'single_signon', { :uid => user.id }
        visit edit_comprehensive_risk_profiler_path
        find("a#skip_quiz").click

        click_on 'Signin & Continue'
        page.current_path.should eq comprehensive_risk_profiler_ideal_investments_path
      end
    end

    def answer_comprehensive_risk_profiler_with(comprehensive_risk_profile)
      visit edit_comprehensive_risk_profiler_path

      fill_in I18n.t("simple_form.labels.comprehensive_risk_profiler.age"),                   :with => comprehensive_risk_profile.age
      fill_in I18n.t("simple_form.labels.comprehensive_risk_profiler.household_savings"),     :with => comprehensive_risk_profile.household_savings
      fill_in I18n.t("simple_form.labels.comprehensive_risk_profiler.household_income"),      :with => comprehensive_risk_profile.household_income
      fill_in I18n.t("simple_form.labels.comprehensive_risk_profiler.dependent"),             :with => comprehensive_risk_profile.dependent
      fill_in I18n.t("simple_form.labels.comprehensive_risk_profiler.household_expenditure"), :with => comprehensive_risk_profile.household_expenditure

      choose  "comprehensive_risk_profiler_preference_#{comprehensive_risk_profile.preference}"
      choose  "comprehensive_risk_profiler_portfolio_investment_#{comprehensive_risk_profile.portfolio_investment}"

      fill_in I18n.t("simple_form.labels.comprehensive_risk_profiler.time_horizon"), :with => comprehensive_risk_profile.time_horizon

      click_button 'Submit'
    end
  end
end
