require 'spec_helper'

describe Subscription do
  let(:current_user) { create :user }
  let(:profile) { create :user }
  let(:subscription) { current_user.subscriptions.create :subscribable => profile }
  subject { subscription }

  its(:user) { should eq current_user }
  its(:subscribable) { should eq profile }
  it "should create reverse association properly" do
    subscription.save
    profile.follows.should include subscription
  end
end
