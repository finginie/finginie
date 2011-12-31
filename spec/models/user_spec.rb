require 'spec_helper'

describe User do
  let(:user) { create :user }
  subject { user }

  it { should have_many :subscriptions }
  it { should have_many :follows }
end
