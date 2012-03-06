require 'spec_helper'

describe GoldTransaction do
  let(:gold_transaction) { create :gold_transaction }
  it { should validate_presence_of :price }
  it { should validate_presence_of :date }
  it { should validate_presence_of :quantity }
  it { should belong_to :portfolio }
  it { should belong_to :gold }
  it { should allow_value(1.day.ago).for(:date) }
  it { should allow_value(Date.today).for(:date) }
  it { should_not allow_value(1.day.from_now).for(:date) }

  it "should get action and amount" do
    gold_transaction.quantity = 20
    gold_transaction.action.should eq :buy
    gold_transaction.amount.should eq 20

    gold_transaction.quantity = -20
    gold_transaction.action.should eq :sell
    gold_transaction.amount.should eq 20
  end

  it "should set action and amount" do
    gold_transaction.action = :buy
    gold_transaction.amount = 20
    gold_transaction.amount.should eq 20

    gold_transaction.action = :sell
    gold_transaction.amount = 10
    gold_transaction.quantity.should eq -10
  end

  it "should not allow sell transaction if there is no buy transaction for gold" do
    gold_transaction.action = :sell
    gold_transaction.amount = 20
    gold_transaction.valid?.should be_false
  end
end
