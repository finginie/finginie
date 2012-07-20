require 'spec_helper'

describe "GoldPosition" do
  let(:portfolio) { create :portfolio }
  before :all do
    create :'data_provider/nse_scrip', :id => "GOLDBEES", :last_traded_price => 5
  end

  subject {
    4.times { |n| create :gold_transaction, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }
    portfolio.gold_transactions.for(DataProvider::Gold)
  }

  its (:quantity) { should eq 10 }
  its (:average_cost_price) { should eq 3 }
  its (:buys) { should include *portfolio.gold_transactions }
  its (:value) { should eq 30 }
  its (:current_value) { should be_a_indian_currency_of 50 }
  its (:unrealised_profit) { should be_a_indian_currency_of 20 }
  its (:unrealised_profit_percentage) { should eq 66.67 }

  context "should calculate after sell transaction" do
    before(:each) do
      subject # ensure stock transaction is saved
      create :gold_transaction, :portfolio => portfolio, :quantity => 4, :action => 'sell', :price => 6, :date => Date.today
    end
    its (:average_cost_price) { should eq 3 }
    its (:value)  { should eq 18 }
    its (:profit_or_loss) { should eq 12 }

    it "should return sell transaction profit or loss" do
      subject.last.profit_or_loss.should eq 12
    end

    its(:average_sell_price) { should eq 6 }
  end

  context "should calculate after sell transaction and a buy transaction" do
    before(:each) do
      subject # ensure stock transaction is saved
      create :gold_transaction, :portfolio => portfolio, :quantity => 4, :action => 'sell', :price => 6, :date => Date.today
      create :gold_transaction, :portfolio => portfolio, :quantity => 3, :action => 'buy', :price => 6, :date => Date.today
      create :gold_transaction, :portfolio => portfolio, :quantity => 4, :action => 'sell', :price => 7, :date => Date.today
    end
    its (:average_cost_price) { should eq 4 }
    its (:value) { should eq 20}
    its(:average_sell_price) { should eq 6.5 }
  end

  it "should calculate profit/loss percentage for Gold" do
    subject # ensure stock transaction is saved
    create :gold_transaction, :portfolio => portfolio, :quantity => 4, :action => 'sell', :price => 6, :date => Date.today
    create :gold_transaction, :portfolio => portfolio, :quantity => 3, :action => 'sell', :price => 2, :date => Date.today
    subject.profit_or_loss.should eq 9
    subject.profit_or_loss_percentage.should eq 42.86
  end

end
