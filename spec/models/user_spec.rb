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
end
