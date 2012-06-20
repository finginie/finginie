require 'spec_helper'

describe SessionsController do
  let(:comprehensive_risk_profiler_attributes) {
    attributes_for :comprehensive_risk_profiler
  }

  describe "POST 'create'" do
    let (:current_user) { create :user }

    before(:each) do
      omniauth = {
        :uid => current_user.id,
        :provider => 'finginie',
        :info => { :email => current_user.email }
      }
      request.env["omniauth.auth"] = omniauth
    end

    it "should be redirect" do
      session[:comprehensive_risk_profiler] = comprehensive_risk_profiler_attributes
      post :create, :provider => 'finginie'
      session[:comprehensive_risk_profiler].should eq nil
      response.should be_redirect
    end
  end
end
