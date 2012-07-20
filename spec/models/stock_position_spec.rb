require 'spec_helper'

describe "StockPosition",:redis, :mongoid do
  let(:portfolio) { create :portfolio }
  let(:company) { create :company_with_scrip, :industry_name => "foo_industry" }

  subject {
    portfolio.stock_transactions.for(company)
  }
  before(:each) do
    company.save
    4.times { |n| create :stock_transaction, :company_code => company.code, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }
  end

  its (:name) { should eq company.name }
  its (:sector) { should eq company.industry_name }
  its (:quantity) { should eq 10 }
  its (:average_cost_price) { should eq 3 }
  its (:value) { should eq 30 }
  its (:current_value) { should be_a_indian_currency_of 50 }
  its (:unrealised_profit) { should be_a_indian_currency_of 20 }
  its (:unrealised_profit_percentage) { should eq 66.67 }

  context "should calculate after sell transaction" do
    before(:each) do
      subject # ensure stock transaction is saved
      create :stock_transaction, :company_code => company.code, :portfolio => portfolio, :quantity => 4, :action => 'sell', :price => 6, :date => Date.today
    end

    its(:average_cost_price) { should eq 3 }
    its(:value) { should eq 18 }
    its(:profit_or_loss) { should eq 12 }

    it "should return sell transaction profit or loss" do
      subject.last.profit_or_loss.should eq 12
    end

    its(:profit_or_loss_percentage) { should eq 100 }

    its(:average_sell_price) { should eq 6 }
  end

  context "should calculate after sell transaction and a buy transaction" do
    before(:each) {
      subject # ensure stock transaction is saved
      create :stock_transaction, :company_code => company.code, :portfolio => portfolio, :quantity => 4, :price => 6, :date => Date.today, :action => "sell"
      create :stock_transaction, :company_code => company.code, :portfolio => portfolio, :quantity => 3 , :price => 6, :date => Date.today, :action => "buy"
      create :stock_transaction, :company_code => company.code, :portfolio => portfolio, :quantity => 4, :price => 7, :date => Date.today, :action => "sell"
      subject.all # force reload all transactions
    }

    its(:average_cost_price) { should eq 4 }
    its(:average_sell_price) { should eq 6.5 }
    its(:value) { should eq 20 }
  end

  it "should calculate average cost price based only on the transactions of current portfolio" do
    create :stock_transaction, :company_code => company.code, :quantity => 10, :price => 5, :date => 5.days.ago
    subject.average_cost_price.should_not == 4
    subject.average_cost_price.should eq 3
  end

  it "should return nil unrealised profit when there is no current price" do
    company_without_current_price = create :'data_provider/company'
    create :stock_transaction, :company_code => company_without_current_price.code, :quantity => 10, :price => 5, :date => 5.days.ago, :portfolio => portfolio
    stock_position = portfolio.stock_transactions.for(company_without_current_price)
    stock_position.unrealised_profit.should eq nil
  end
end
