require 'spec_helper'

describe User do
  let(:user) { create :user }
  subject { user }
  let(:auth_hash) {
    {
      :provider => 'facebook',
      :uid => '12345',
      :info => {
        :email => 'joe@somewhere.com'
      }
    }
  }

  it { should have_many :subscriptions }
  it { should have_many :follows }
  it { should have_many :authentications }
  it { should have_one  :comprehensive_risk_profiler }

  it "should find a user by his authentication" do
    authentication = create :authentication, :user => user, :provider => auth_hash[:provider], :uid => auth_hash[:uid]
    User.find_or_create_by_omniauth(auth_hash).should eq user
  end

  context "with new authentication" do
    let(:user) { User.find_or_create_by_omniauth(auth_hash) }

    its(:persisted?) { should be_true }
    its(:email) { should eq 'joe@somewhere.com' }
    context "'s authention" do
      subject { user.authentications.first }

      its(:provider) { should eq 'facebook' }
      its(:uid) { should eq '12345' }
    end
  end

  context "with existing comprehensive risk profiler" do
    let(:user) { User.find_or_create_by_omniauth(auth_hash) }

    context "should merge with comprehensive risk profiler" do
      let(:comprehensive_risk_profiler) { build :comprehensive_risk_profiler }
      subject { user.merge_comprehensive_risk_profiler(comprehensive_risk_profiler.attributes).comprehensive_risk_profiler }
      its(:score) { should eq comprehensive_risk_profiler.score }
    end

    let(:comprehensive_risk_profiler) { create :comprehensive_risk_profiler, :user => user }
    it "should not create new record" do
      comprehensive_risk_profiler.save
      user.merge_comprehensive_risk_profiler(comprehensive_risk_profiler.attributes)
      ComprehensiveRiskProfiler.count.should eq 1
    end
  end
end
