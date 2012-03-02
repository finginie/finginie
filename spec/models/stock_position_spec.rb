require 'spec_helper'

describe "StockPosition" do
  let(:portfolio) { create :portfolio }
  let(:stock) { create :stock }
  let(:scrip) { create :scrip, :last_traded_price => 5, :id => stock.symbol}

  subject {
    scrip.save
    4.times { |n| create :stock_transaction, :stock => stock, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }
    portfolio.stock_transactions.for(stock)
  }

  its (:name) { should eq stock.name }
  its (:quantity) { should eq 10 }
  its (:average_cost_price) { should eq 3 }
  its (:buy_transactions) { should include *portfolio.stock_transactions }
  its (:total_cost) { should eq 30 }
  its (:current_value) { should eq 50 }
  its (:unrealised_profit) { should eq 20 }

  it "should calculate the average cost price after sell transaction" do
    create :stock_transaction, :stock => stock, :portfolio => portfolio, :quantity => -4, :price => 6, :date => Date.today
    subject.average_cost_price.should eq 3
    subject.total_cost.should eq 18
    subject.profit_or_loss.should eq 12
    subject.last.profit_or_loss.should eq 12
  end

  it "should calculate the average cost price after sell tranaction and a buy transaction" do
    create :stock_transaction, :stock => stock, :portfolio => portfolio, :quantity => -4, :price => 6, :date => Date.today
    create :stock_transaction, :stock => stock, :portfolio => portfolio, :quantity => 3 , :price => 6, :date => Date.today
    subject.average_cost_price.should eq 4
    subject.total_cost.should eq 36
  end

end
