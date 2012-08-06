require 'spec_helper'

describe SocialNetworkController do
  describe "GET 'facebook_callback'" do
    let (:current_user) { create :user }

    before(:each) do
      session[:user_id] = current_user.id
    end

    it "should redirect to facebook redirect_uri" do
      origin_url = 'http://test.com/comprehensive_risk_profiler'
      get :facebook_callback, :step_id => Step::SHARE_FINANCIAL_PROFILE_ON_FB, :return_to => origin_url
      response.should redirect_to(origin_url)
    end

    it "should save completed_step only when published on fb wall" do
      current_user.should_not be_completed_share_financial_profile_on_fb_step
      # CompletedStep.find_by_step_id_and_user_id(Step::SHARE_FINANCIAL_PROFILE_ON_FB, current_user.id).should be_nil
      get :facebook_callback, :step_id => Step::SHARE_FINANCIAL_PROFILE_ON_FB, :return_to => 'http://test.com/comprehensive_risk_profiler', :post_id => 'abca123'
      current_user.should be_completed_share_financial_profile_on_fb_step
    end

    it "shouldn't save completed_step when not published on fb wall" do
      current_user.should_not be_completed_share_financial_profile_on_fb_step
      get :facebook_callback, :step_id => Step::SHARE_FINANCIAL_PROFILE_ON_FB, :return_to => 'http://test.com/comprehensive_risk_profiler'
      current_user.should_not be_completed_share_financial_profile_on_fb_step
    end

    it "should store facebook post_id in completed_step data" do
      post_id = 'abca123'
      get :facebook_callback, :step_id => Step::SHARE_FINANCIAL_PROFILE_ON_FB, :return_to => 'http://test.com/comprehensive_risk_profiler', :post_id => post_id
      completed_step = CompletedStep.find_by_step_id_and_user_id(Step::SHARE_FINANCIAL_PROFILE_ON_FB, current_user.id)
      completed_step.data['post_id'].should eq post_id
    end

  end
end