require 'spec_helper'

describe SessionsController do
  let(:comprehensive_risk_profiler_attributes) {
    attributes_for :comprehensive_risk_profiler
  }

  describe "POST 'create'" do
    let (:authentication) { create :authentication }

    before(:each) do
      omniauth = {
        :uid => authentication.uid,
        :provider => authentication.provider,
        :info => { :email => authentication.user.email }
      }
      request.env["omniauth.auth"] = omniauth
    end

    it "should be redirect" do
      session[:comprehensive_risk_profiler] = comprehensive_risk_profiler_attributes
      post 'create'
      session[:comprehensive_risk_profiler].should eq nil
      response.should be_redirect
    end
  end
end
