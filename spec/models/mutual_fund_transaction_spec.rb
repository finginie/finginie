require 'spec_helper'

describe MutualFundTransaction do
  let(:mutual_fund_transaction) { create :mutual_fund_transaction }
  it { should validate_presence_of :price }
  it { should validate_presence_of :date }
  it { should validate_presence_of :quantity }
  it { should belong_to :portfolio }
  it { should belong_to :mutual_fund }
  it { should allow_value(1.day.ago).for(:date) }
  it { should allow_value(Date.today).for(:date) }
  it { should_not allow_value(1.day.from_now).for(:date) }

  it "should get action and amount" do
    mutual_fund_transaction.quantity = 20
    mutual_fund_transaction.action.should eq :buy
    mutual_fund_transaction.amount.should eq 20

    mutual_fund_transaction.quantity = -20
    mutual_fund_transaction.action.should eq :sell
    mutual_fund_transaction.amount.should eq 20
  end

  it "should set action and amount" do
    mutual_fund_transaction.action = :buy
    mutual_fund_transaction.amount = 20
    mutual_fund_transaction.amount.should eq 20

    mutual_fund_transaction.action = :sell
    mutual_fund_transaction.amount = 10
    mutual_fund_transaction.quantity.should eq -10
  end

  it "should not allow sell transaction if there is no buy transaction for that stock" do
    mutual_fund_transaction.action = :sell
    mutual_fund_transaction.amount = 20
    mutual_fund_transaction.valid?.should be_false
  end

end

