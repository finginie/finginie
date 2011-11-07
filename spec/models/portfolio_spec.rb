require 'spec_helper'

describe Portfolio do
  let(:portfolio) { create :portfolio }
  subject { portfolio }

  it { should belong_to :user }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :name }
  it {  create :portfolio, :user_id => portfolio.user_id
        should validate_uniqueness_of(:name).scoped_to(:user_id)
     }
end
