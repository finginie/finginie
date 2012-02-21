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
  end
end
