require 'spec_helper'

describe "MutualFundPosition" do

  let(:portfolio) { create :portfolio }
  let(:scheme) { create :scheme, :nav_amount => "5" }
  let(:mutual_fund) { create :mutual_fund, :name => scheme.scheme_name }

  subject {
    4.times { |n| create :mutual_fund_transaction, :mutual_fund => mutual_fund, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }
    portfolio.mutual_fund_transactions.for(mutual_fund)
  }

  its (:name) { should eq scheme.scheme_name }
  its (:quantity) { should eq 10 }
  its (:average_cost_price) { should eq 3 }
  its (:buys) { should include *portfolio.mutual_fund_transactions }
  its (:value) { should eq 30 }
  its (:current_value) { should eq 50 }
  its (:unrealised_profit) { should eq 20 }

  it "should calculate the average cost price after sell transaction" do
    subject # ensure mutual transaction is saved
    create :mutual_fund_transaction, :mutual_fund => mutual_fund, :portfolio => portfolio, :quantity => 4, :price => 6, :date => Date.today, :action => "sell"
    subject.average_cost_price.should eq 3
    subject.value.should eq 18
    subject.profit_or_loss.should eq 12
    subject.last.profit_or_loss.should eq 12
  end

  it "should calcualte the profit_or_loss_percentage for a position" do
    subject # ensure mutual transaction is saved
    create :mutual_fund_transaction, :mutual_fund => mutual_fund, :portfolio => portfolio, :quantity => 3, :price => 6, :date => Date.today, :action => "sell"
    create :mutual_fund_transaction, :mutual_fund => mutual_fund, :portfolio => portfolio, :quantity => 4, :price => 1, :date => Date.today, :action => "sell"
    subject.profit_or_loss.should eq 1
    subject.profit_or_loss_percentage.should eq 4.76
  end

  it "should return nil unrealised profit when there is no current price" do
    scheme_without_nav_amount = create :scheme
    mutual_fund_without_current_price = create :mutual_fund, :name => scheme_without_nav_amount.scheme_name
    create :mutual_fund_transaction, :scheme => scheme_without_nav_amount.scheme_name, :quantity => 10, :price => 5, :date => 5.days.ago, :portfolio => portfolio
    mutual_fund_position = portfolio.mutual_fund_transactions.for(mutual_fund_without_current_price)
    mutual_fund_position.unrealised_profit.should eq nil
  end
end
