require 'spec_helper'

describe "StockPosition",:redis do
  let(:portfolio) { create :portfolio }
  let(:company) { create :company_with_scrip, :industry_name => "foo_industry" }

  subject {
    portfolio.stock_transactions.for(company)
  }
  before(:each) do
    company.save
    4.times { |n| create :stock_transaction, :company_code => company.company_code, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }
  end

  its (:name) { should eq company.company_name }
  its (:sector) { should eq company.industry_name }
  its (:quantity) { should eq 10 }
  its (:average_cost_price) { should eq 3 }
  its (:value) { should eq 30 }
  its (:current_value) { should eq 50 }
  its (:unrealised_profit) { should eq 20 }

  it "should calculate the average cost price after sell transaction" do
    subject # ensure stock transaction is saved
    create :stock_transaction, :company_code => company.company_code, :portfolio => portfolio, :quantity => 4, :action => 'sell', :price => 6, :date => Date.today
    subject.average_cost_price.should eq 3
    subject.value.should eq 18
    subject.profit_or_loss.should eq 12
    subject.last.profit_or_loss.should eq 12
    subject.profit_or_loss_percentage.should eq 100
  end

  it "should calculate the average cost price after sell tranaction and a buy transaction" do
    subject # ensure stock transaction is saved
    create :stock_transaction, :company_code => company.company_code, :portfolio => portfolio, :quantity => 4, :price => 6, :date => Date.today, :action => "sell"
    create :stock_transaction, :company_code => company.company_code, :portfolio => portfolio, :quantity => 3 , :price => 6, :date => Date.today, :action => "buy"
    subject.all # force reload all transactions
    subject.average_cost_price.should eq 4
    subject.value.should eq 36
  end

  it "should calculate average cost price based only on the transactions of current portfolio" do
    create :stock_transaction, :company_code => company.company_code, :quantity => 10, :price => 5, :date => 5.days.ago
    subject.average_cost_price.should_not == 4
    subject.average_cost_price.should eq 3
  end

  it "should return nil unrealised profit when there is no current price" do
    company_without_current_price = create :company
    create :stock_transaction, :company_code => company_without_current_price.company_code, :quantity => 10, :price => 5, :date => 5.days.ago, :portfolio => portfolio
    stock_position = portfolio.stock_transactions.for(company_without_current_price)
    stock_position.unrealised_profit.should eq nil
  end
end
