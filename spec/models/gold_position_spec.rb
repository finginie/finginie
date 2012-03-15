require 'spec_helper'

describe "GoldPosition" do
  let(:portfolio) { create :portfolio }
  let(:gold) { create :gold, :name => "Gold", :current_price => 5 }

  subject {
    gold.save
    4.times { |n| create :gold_transaction, :gold => gold, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }
    portfolio.gold_transactions

  }

  its (:name) { should eq gold.name }
  its (:quantity) { should eq 10 }
  its (:average_cost_price) { should eq 3 }
  its (:buy_transactions) { should include *portfolio.gold_transactions }
  its (:value) { should eq 30 }
  its (:current_value) { should eq 50 }
  its (:unrealised_profit) { should eq 20 }

  it "should calculate the average cost price after sell transaction" do
    subject # ensure stock transaction is saved
    create :gold_transaction, :gold => gold, :portfolio => portfolio, :quantity => -4, :price => 6, :date => Date.today
    subject.average_cost_price.should eq 3
    subject.value.should eq 18
    subject.profit_or_loss.should eq 12
    subject.last.profit_or_loss.should eq 12
  end

  it "should calculate the average cost price after sell tranaction and a buy transaction" do
    subject # ensure stock transaction is saved
    create :gold_transaction, :gold => gold, :portfolio => portfolio, :quantity => -4, :price => 6, :date => Date.today
    create :gold_transaction, :gold => gold, :portfolio => portfolio, :quantity => 3 , :price => 6, :date => Date.today
    subject.average_cost_price.should eq 4
    subject.value.should eq 36
  end

end
