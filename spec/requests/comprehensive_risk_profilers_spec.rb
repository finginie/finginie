require 'spec_helper'

describe "ComprehensiveRiskProfilers" do
  context "#edit" do
    let(:comprehensive_risk_profiler) { build :comprehensive_risk_profiler }

    before(:each){ visit edit_comprehensive_risk_profiler_path }

    context "if quiz is answered " do
      before(:each) { answer_comprehensive_risk_profiler_with(comprehensive_risk_profiler) }

      it "should show the score on page" do
        page.should have_content I18n.t(".comprehensive_risk_profilers.success_message")
        page.should have_content "Your Risk Appetite is : #{comprehensive_risk_profiler.score.round}"
      end

      it "should show the login link on page" do
        within "#continue" do
          page.should have_link('Signin')
        end
      end
    end

    it "should show the hidden questions by default" do
      page.find_by_id('special_goals_field').visible?.should be_true
      page.find_by_id('tax_saving_investment_field').visible?.should be_true
    end

    it "should hide the questions by default if js is available", :js => true do
      page.find_by_id('special_goals_field').visible?.should be_false
      page.find_by_id('tax_saving_investment_field').visible?.should be_false
    end

    it "should show special goals section when user enables it", :js => true do
      within "#special_goals" do
        choose  'Yes'
      end
      page.find_by_id('special_goals_field').visible?.should be_true
    end

    it "should show tax saving investments section when user enables it", :js => true do
      within "#tax_saving_investment" do
        choose  'Yes'
      end

      page.find_by_id('tax_saving_investment_field').visible?.should be_true
    end

    it "should raise error for an invalid answer" do
      fill_in I18n.t("simple_form.labels.comprehensive_risk_profiler.age"), :with => "abc"
      click_button 'Submit'

      page.should have_selector('#comprehensive_risk_profiler_age+div.error')
    end
  end

  context "A user irrespective of registration status " do

    context "who hasnt taken the Comprehensive Risk Profiling quiz" do
      it "should be redirected to the Comprehensive Risk Profiling Quiz Page" do
        visit comprehensive_risk_profiler_url

        current_path.should eq edit_comprehensive_risk_profiler_path
        page.should have_content I18n.t('.comprehensive_risk_profilers.message')
      end
    end

    context "who has taken the Comprehensive Risk Profiling quiz" do
      include_context "logged in user"

      let(:comprehensive_risk_profiler) { create :comprehensive_risk_profiler, :user => current_user }

      it "should be able to see his risk appetite score" do
        comprehensive_risk_profiler.save

        visit comprehensive_risk_profiler_url

        page.should have_content "Your Risk Appetite is : #{comprehensive_risk_profiler.score.round}"
      end

      it "should be able to see his ideal asset allocation" do
        comprehensive_risk_profiler.save

        visit comprehensive_risk_profiler_url

        FinancialPlanner.ideal_asset_allocation(comprehensive_risk_profiler).each do |asset_class, percentage|
          page.should have_content "#{asset_class} #{percentage}%"
        end
      end
    end
  end

  context "logged in user" do
    include_context "logged in user"

    it "who hasnt taken the Comprehensive Risk Profiling quiz should be redirected to the Comprehensive Risk Profiling Quiz Page" do
      visit comprehensive_risk_profiler_url

      current_path.should eq edit_comprehensive_risk_profiler_path

      page.should have_content I18n.t('.comprehensive_risk_profilers.message')
    end

    let(:comprehensive_risk_profiler) { build :comprehensive_risk_profiler }

    context "if quiz is answered " do
      before(:each) do
        visit edit_comprehensive_risk_profiler_path
        answer_comprehensive_risk_profiler_with(comprehensive_risk_profiler)
      end

      it "should show the score on page" do
        page.should have_content "Your Risk Appetite is : #{comprehensive_risk_profiler.score.round}"
      end

      it "shouldn't show the login link on page" do
        page.should_not have_link('Signin')
      end

      it"should show the continue link on page" do
        page.should have_link('Continue')
      end
    end
  end

  def answer_comprehensive_risk_profiler_with(comprehensive_risk_profiler)
    fill_in I18n.t("simple_form.labels.comprehensive_risk_profiler.age"),                   :with => comprehensive_risk_profiler.age
    fill_in I18n.t("simple_form.labels.comprehensive_risk_profiler.household_savings"),     :with => comprehensive_risk_profiler.household_savings
    fill_in I18n.t("simple_form.labels.comprehensive_risk_profiler.household_income"),      :with => comprehensive_risk_profiler.household_income
    fill_in I18n.t("simple_form.labels.comprehensive_risk_profiler.dependent"),             :with => comprehensive_risk_profiler.dependent
    fill_in I18n.t("simple_form.labels.comprehensive_risk_profiler.household_expenditure"), :with => comprehensive_risk_profiler.household_expenditure

    choose  "comprehensive_risk_profiler_preference_#{comprehensive_risk_profiler.preference}"
    choose  "comprehensive_risk_profiler_portfolio_investment_#{comprehensive_risk_profiler.portfolio_investment}"

    fill_in I18n.t("simple_form.labels.comprehensive_risk_profiler.time_horizon"), :with => comprehensive_risk_profiler.time_horizon

    click_button 'Submit'
  end
end
