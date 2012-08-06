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

  it { should have_many :subscriptions }
  it { should have_many :follows }
  it { should have_one  :comprehensive_risk_profiler }

  context "#already_referred?" do
    it "should return true if user is already referred" do
      create :completed_step, { :user_id => create(:user).id, :step_id => Step::REFERRAL, :data    => { :referred_user_id => user.id } }
      user.should be_already_referred
    end

    it "should return false if user is not a referred user" do
      user.should_not be_already_referred
    end
  end

  it "should find a user by his authentication" do
    User.find_or_create_by_omniauth(auth_hash).should eq user
  end

  context "with new authentication" do
    let(:current_user) { User.find_or_create_by_omniauth(auth_hash) }

    its(:persisted?) { should be_true }
    its(:email) { should eq 'joe@somewhere.com' }
  end

  context "with comprehensive risk profiler in session" do
    let(:comprehensive_risk_profiler_attributes) {
      attributes_for  :comprehensive_risk_profiler, :age => 245, :household_savings => 823
    }

    it "should merge comprehensive risk profiler attributes" do
      user.merge_comprehensive_risk_profiler(comprehensive_risk_profiler_attributes)
      user.comprehensive_risk_profiler.age.should eq 245
      user.comprehensive_risk_profiler.household_savings.should eq 823
    end

    it "should not overwrite existing comprehensive risk profiler" do
      create :comprehensive_risk_profiler, :user => user, :age => 28, :household_savings => 4000
      user.merge_comprehensive_risk_profiler(comprehensive_risk_profiler_attributes)
      user.comprehensive_risk_profiler.age.should eq 28
      user.comprehensive_risk_profiler.household_savings.should eq 4000
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
end
