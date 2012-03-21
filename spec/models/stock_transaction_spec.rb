require 'spec_helper'

describe StockTransaction do
  let(:stock_transaction) { create :stock_transaction }
  subject { stock_transaction }

  it { should validate_presence_of :price }
  it { should validate_presence_of :date }
  it { should validate_presence_of :quantity }
  it { should validate_presence_of :action }
  it { should validate_numericality_of :price }
  it { should validate_numericality_of :quantity }
  it { should belong_to :portfolio }
  it { should belong_to :stock }
  it { should allow_value(1.day.ago).for(:date) }
  it { should allow_value(Date.today).for(:date) }
  it { should_not allow_value(1.day.from_now).for(:date) }
  it { should_not allow_value(-1).for(:price) }
  it { should_not allow_value(-1).for(:quantity) }

  it "should get amount" do
    stock_transaction.action = "buy"
    stock_transaction.quantity = 20
    stock_transaction.amount.should eq 20

    stock_transaction.action = "sell"
    stock_transaction.quantity = 10
    stock_transaction.amount.should eq -10
  end

  it "should not allow sell transaction if there is no buy transaction for that stock" do
    stock_transaction.action = "sell"
    stock_transaction.quantity = 20
    stock_transaction.valid?.should be_false
  end
end
