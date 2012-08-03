require 'spec_helper'

describe "Public Financial Profile" do
  let(:user) { create :user_with_profile }
  let(:comprehensive_risk_profiler) { create :comprehensive_risk_profiler, :user => user }

  context "owner taken quiz" do
    before(:each) do
      comprehensive_risk_profiler.save
      visit public_financial_profile_path(user)
    end

    context "#financial advise" do
      it "should have public summary" do
        page.should have_span_data_role('public_summary')
      end

      it "should have score" do
        span_data_role('risk_appetite').should eq comprehensive_risk_profiler.score.round.to_s
      end
    end
  end

  context "general" do
    before(:each) do
      comprehensive_risk_profiler.save
      visit public_financial_profile_path(user)
    end

    it "should have asset_allocation data" do
      expected_content = [ ['Fixed Deposits', '50%'], [ 'Large Cap Stocks', '25%'], [ 'Mid Cap Stocks', '0%'], [ 'Gold', '25%']]
      tableish("table").should include *expected_content
    end

    it "should have quiz link" do
      page.should have_link(I18n.t('comprehensive_risk_profilers.public.take_quiz'))
    end

    it "can be viewed by any user" do
      page.current_path.should eq public_financial_profile_path(user)
    end
  end

  context "owner skipped quiz" do
    before(:each) do
      c = ComprehensiveRiskProfiler.new(:score_cache => ComprehensiveRiskProfiler::DEFAULT_SCORE ) # TODO: should do this more gracefully
      c.user = user
      c.save(:validate => false)
      visit public_financial_profile_path(user)
    end

    it "should not have public_summary" do
      page.should_not have_span_data_role('public_summary') #TODO: refactor this
    end

    it "should not have risk_appetite score" do
      page.should_not have_span_data_role('risk_appetite')
    end

    it "should have balanced portfolio" do
      page.should have_span_data_role('balanced_portfolio')
    end
  end

  context "owner viewing his own public profile page" do
    include_context "logged in user"
    it "should not have take quiz link" do
      create :comprehensive_risk_profiler, :user => current_user
      visit public_financial_profile_path(current_user)
      page.should_not have_link(I18n.t('comprehensive_risk_profilers.public.take_quiz'))
    end
  end

 end