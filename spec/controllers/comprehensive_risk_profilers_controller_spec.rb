require 'spec_helper'

describe ComprehensiveRiskProfilersController do

  let(:comprehensive_risk_profiler_attributes) {
attributes_for :comprehensive_risk_profiler, :household_savings => 123456
  }

  describe "GET 'edit'" do
    it "should be success" do
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be redirect" do
      get 'show'
      response.should be_redirect
    end

    it "should be success'" do
      session[:comprehensive_risk_profiler] = comprehensive_risk_profiler_attributes
      get 'show'
      response.should be_success
    end
  end

  describe "POST 'update'" do
    it "should be redirect" do
      post 'update', :comprehensive_risk_profiler => comprehensive_risk_profiler_attributes
      response.should be_redirect
      session[:comprehensive_risk_profiler]["household_savings"].should eq "123456"
    end
  end
end
