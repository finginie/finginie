require 'spec_helper'

describe "MutualFundPosition", :mongoid do

  let(:portfolio) { create :portfolio }
  let(:scheme) { create :'data_provider/scheme', :nav_amount => "5" }
  let(:mutual_fund) { create :mutual_fund, :name => scheme.name }

  subject {
    4.times { |n| create :mutual_fund_transaction, :mutual_fund => mutual_fund, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }
    portfolio.mutual_fund_transactions.for(mutual_fund)
  }

  its (:name) { should eq scheme.name }
  its (:quantity) { should eq 10 }
  its (:average_cost_price) { should be_a_indian_currency_of 2.99 }
  its (:buys) { should include *portfolio.mutual_fund_transactions }
  its (:value) { should be_a_indian_currency_of 29.9 }
  its (:current_value) { should be_a_indian_currency_of 50 }
  its (:unrealised_profit) { should be_a_indian_currency_of 20.1 }
  its (:unrealised_profit_percentage) { should eq 67.22 }

  context "should calculate after sell transaction" do
    before(:each) {
      subject # ensure mutual transaction is saved
      create :mutual_fund_transaction, :mutual_fund => mutual_fund, :portfolio => portfolio, :quantity => 4, :price => 6, :date => Date.today, :action => "sell"
    }
    its(:average_cost_price) { should be_a_indian_currency_of 2.99 }
    its(:value) { should be_a_indian_currency_of 17.94 }
    its(:profit_or_loss) { should be_a_indian_currency_of 12.04 }

    it "should return sell transaction profit or loss" do
      subject.last.profit_or_loss.should be_a_indian_currency_of 12.04
    end

    its(:average_sell_price) { should eq 6 }
  end

  context "should calculate after sell transaction and a buy transaction" do
    before(:each) {
      subject # ensure mutual transaction is saved
      create :mutual_fund_transaction, :mutual_fund => mutual_fund, :portfolio => portfolio, :quantity => 3, :price => 6, :date => Date.today, :action => "sell"
      create :mutual_fund_transaction, :mutual_fund => mutual_fund, :portfolio => portfolio, :quantity => 4, :price => 1, :date => Date.today, :action => "sell"
    }
    its(:profit_or_loss) { should be_a_indian_currency_of 1.07 }
    its(:average_sell_price) { should eq 3.14 }
    its(:profit_or_loss_percentage) { should be_a_indian_currency_of 5.11 }
  end

  it "should return nil unrealised profit when there is no current price" do
    scheme_without_nav_amount = create :'data_provider/scheme', :nav_amount => nil
    mutual_fund_without_current_price = create :mutual_fund, :name => scheme_without_nav_amount.name
    create :mutual_fund_transaction, :scheme => scheme_without_nav_amount.name, :quantity => 10, :price => 5, :date => 5.days.ago, :portfolio => portfolio
    mutual_fund_position = portfolio.mutual_fund_transactions.for(mutual_fund_without_current_price)
    mutual_fund_position.unrealised_profit.should eq nil
  end
end
