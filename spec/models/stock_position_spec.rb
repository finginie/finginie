require 'spec_helper'

describe "StockPosition" do
  let(:portfolio) { create :portfolio }
  let(:stock) { create :stock }
  let(:scrip) { create :scrip, :last_traded_price => 5, :id => stock.symbol}

  subject {
    portfolio.stock_transactions.for(stock)
  }
  before(:each) do
    scrip.save
    4.times { |n| create :stock_transaction, :stock => stock, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }
  end

  its (:name) { should eq stock.name }
  its (:quantity) { should eq 10 }
  its (:average_cost_price) { should eq 3 }
  its (:value) { should eq 30 }
  its (:current_value) { should eq 50 }
  its (:unrealised_profit) { should eq 20 }

  it "should calculate the average cost price after sell transaction" do
    subject # ensure stock transaction is saved
    create :stock_transaction, :stock => stock, :portfolio => portfolio, :quantity => 4, :action => 'sell', :price => 6, :date => Date.today
    subject.average_cost_price.should eq 3
    subject.value.should eq 18
    subject.profit_or_loss.should eq 12
    subject.last.profit_or_loss.should eq 12
    subject.profit_or_loss_percentage.should eq 100
  end

  it "should calculate the average cost price after sell tranaction and a buy transaction" do
    subject # ensure stock transaction is saved
    create :stock_transaction, :stock => stock, :portfolio => portfolio, :quantity => 4, :price => 6, :date => Date.today, :action => "sell"
    create :stock_transaction, :stock => stock, :portfolio => portfolio, :quantity => 3 , :price => 6, :date => Date.today, :action => "buy"
    subject.all # force reload all transactions
    subject.average_cost_price.should eq 4
    subject.value.should eq 36
  end

  it "should calculate average cost price based only on the transactions of current portfolio" do
    create :stock_transaction, :stock => stock, :quantity => 10, :price => 5, :date => 5.days.ago
    subject.average_cost_price.should_not == 4
    subject.average_cost_price.should eq 3
  end

end
