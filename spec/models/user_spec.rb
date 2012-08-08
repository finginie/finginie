require 'spec_helper'

describe User do
  let(:user) { create :user, email:"joe@somewhere.com"}
  subject { user }
  let(:auth_hash) {
    {
      :provider => 'finginie',
      :uid => user.id,
      :info => {
        :email => 'joe@somewhere.com'
      }
    }
  }

  it { should have_many(:steps).through(:completed_steps) }
  it { should have_many :completed_steps }
  it { should have_many :subscriptions }
  it { should have_many :follows }
  it { should have_one :comprehensive_risk_profiler }

  context "with new authentication" do
    let(:current_user) { User.find_or_create_by_omniauth(auth_hash) }

    its(:persisted?) { should be_true }
    its(:email) { should eq 'joe@somewhere.com' }
  end


  it "should find a user by his authentication" do
    User.find_or_create_by_omniauth(auth_hash).should eq user
  end

  describe "#has_no_comprehensive_risk_profiler?" do
    it "should return true if user has no comprehensive_risk_profiler" do
      create :comprehensive_risk_profiler, :user => user
      user.has_no_comprehensive_risk_profiler?.should_not be
    end

    it "should return false if user has comprehensive_risk_profiler" do
      user.has_no_comprehensive_risk_profiler?.should be
    end
  end

  context "#completed_referral_step?" do
    it "should return true if user is already referred" do
      create :completed_step, { :user_id => user.id, :step_id => Step::REFERRAL, :data    => { :referred_user_id => create(:user).id } }
      user.should be_completed_referral_step
    end

    it "should return false if user is not a referred user" do
      user.should_not be_completed_referral_step
    end
  end

  context "#already_referred?" do
    it "should return true if user is already referred" do
      create :completed_step, { :user_id => create(:user).id, :step_id => Step::REFERRAL, :data    => { :referred_user_id => user.id } }
      user.should be_already_referred
    end

    it "should return false if user is not a referred user" do
      user.should_not be_already_referred
    end
  end

  it "should delete associate child records" do
    user = create :user
    portfolio = create :portfolio, user: user
    comprehensive_risk_profiler = create :comprehensive_risk_profiler, :user => user
    lambda {
        user.destroy
    }.should change(Portfolio, :count).by(-1)
    change(ComprehensiveRiskProfiler, :count).by(-1)
  end

end
