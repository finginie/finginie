require 'spec_helper'

describe NetPosition do
  let (:security) { create :security, :current_price => 20 }
  let (:net_position) { create :net_position, :security_id => security.id }
  subject { net_position }

  it { should have_many :transactions }
  it { should belong_to :portfolio }
  it { should belong_to :security }
  it { should validate_presence_of :security_id }
  it { should validate_presence_of :portfolio_id }

  before { net_position.transactions.create attributes_for(:transaction, :quantity => 10) }
  it "should calculate net quantity" do
    net_position.quantity.should eq 10
    net_position.transactions.create attributes_for(:transaction, :quantity => 20)
    net_position.quantity.should eq 30
    net_position.transactions.create attributes_for(:transaction, :quantity => -5)
    net_position.quantity.should eq 25
  end

  its(:current_market_value) { should eq 200 }
end
