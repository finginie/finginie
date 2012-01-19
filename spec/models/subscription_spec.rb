require 'spec_helper'

describe Subscription do
  let(:current_user) { create :user }
  let(:profile) { create :user }
  let(:subscription) { current_user.subscriptions.create :subscribable => profile }
  subject { subscription }

  it { should validate_presence_of :user_id }
  it {
    should validate_presence_of :subscribable_id
    should validate_presence_of :subscribable_type
  }

  it { should validate_uniqueness_of(:subscribable_id).scoped_to(:user_id, :subscribable_type) }

  its(:user) { should eq current_user }
  its(:subscribable) { should eq profile }
  it "should create reverse association properly" do
    subscription.save
    profile.follows.should include subscription
  end
end
