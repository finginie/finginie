require 'spec_helper'

describe Transaction do
  let(:transaction) { create :transaction }
  it { should validate_presence_of :date }
  it { should allow_value(1.day.ago).for(:date) }
  it { should allow_value(Date.today).for(:date) }
  it { should_not allow_value(1.day.from_now).for(:date) }
  it { should validate_presence_of :price }
  it { should validate_presence_of :quantity }
  it { should validate_presence_of :net_position_id }

  it "should get action and amount" do
    transaction.quantity = 20
    transaction.action.should eq :buy
    transaction.amount.should eq 20

    transaction.quantity = -20
    transaction.action.should eq :sell
    transaction.amount.should eq 20
  end

  it "should set action and amount" do
    transaction.action = :buy
    transaction.amount = 20
    transaction.amount.should eq 20

    transaction.action = :sell
    transaction.amount = 10
    transaction.quantity.should eq -10
  end

end
