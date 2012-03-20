require 'spec_helper'

describe "MutualFundPosition" do

  let(:portfolio) { create :portfolio }
  let(:scheme) { create :scheme_master }
  let(:navcp) { create :navcp, :nav_amount => "5", :security_code => scheme.securitycode }
  let(:mutual_fund) { create :mutual_fund, :name => scheme.scheme_name }

  subject {
    navcp.save
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
end
