require 'spec_helper'

describe "GoldPosition" do
  let(:portfolio) { create :portfolio }
  before :all do
    Gold.current_price = 5
  end

  subject {
    4.times { |n| create :gold_transaction, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }
    portfolio.gold_transactions.for(Gold)
  }

  its (:quantity) { should eq 10 }
  its (:average_cost_price) { should eq 3 }
  its (:buys) { should include *portfolio.gold_transactions }
  its (:value) { should eq 30 }
  its (:current_value) { should eq 50 }
  its (:unrealised_profit) { should eq 20 }

  it "should calculate the average cost price after sell transaction" do
    subject # ensure stock transaction is saved
    create :gold_transaction, :portfolio => portfolio, :quantity => 4, :action => 'sell', :price => 6, :date => Date.today
    subject.average_cost_price.should eq 3
    subject.value.should eq 18
    subject.profit_or_loss.should eq 12
    subject.last.profit_or_loss.should eq 12
  end

  it "should calculate the average cost price after sell tranaction and a buy transaction" do
    subject # ensure stock transaction is saved
    create :gold_transaction, :portfolio => portfolio, :quantity => 4, :action => 'sell', :price => 6, :date => Date.today
    create :gold_transaction, :portfolio => portfolio, :quantity => 3, :action => 'buy', :price => 6, :date => Date.today
    subject.average_cost_price.should eq 4
    subject.value.should eq 36
  end

  it "should calculate profit/loss percentage for Gold" do
    subject # ensure stock transaction is saved
    create :gold_transaction, :portfolio => portfolio, :quantity => 4, :action => 'sell', :price => 6, :date => Date.today
    create :gold_transaction, :portfolio => portfolio, :quantity => 3, :action => 'sell', :price => 2, :date => Date.today
    subject.profit_or_loss.should eq 9
    subject.profit_or_loss_percentage.should eq 42.86
  end

end
