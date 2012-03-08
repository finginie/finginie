require 'spec_helper'

describe Portfolio do
  let(:portfolio) { create :portfolio }
  subject { portfolio }

  it { should belong_to :user }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :name }
  it {  create :portfolio, :user_id => portfolio.user_id
        should validate_uniqueness_of(:name).scoped_to(:user_id)
     }

  it { should have_many :stock_transactions }
  it { should have_many :mutual_fund_transactions }
  it { should have_many :gold_transactions }
  it { should have_many :loan_transactions }
  it { should have_many :fixed_deposit_transactions }
  it { should have_many :real_estate_transactions }
  its(:net_worth) { should eq 0 }
  its(:total_assets_value) { should eq 0 }
  its(:total_liabilitites_value) { should eq 0 }

  it "should have many stock_positions" do
    stock = create :stock
    4.times { |n| create :stock_transaction, :stock => stock, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }
    4.times { |n| create :stock_transaction, :stock => create( :stock), :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    portfolio.stock_positions.first.quantity.should eq 10
    portfolio.stock_positions.first.average_cost_price.should eq 3
  end

  it "should have many mutual_fund_positions" do
    scheme = create :scheme_master
    4.times { |n| create :mutual_fund_transaction, :mutual_fund => create(:mutual_fund, :name => scheme.scheme_name), :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    portfolio.mutual_fund_positions.first.quantity.should eq 10
    portfolio.mutual_fund_positions.first.average_cost_price.should eq 3
  end

  it "should have a gold position" do
    gold = create :gold, :name => "Gold", :current_price => 5
    4.times { |n| create :gold_transaction, :gold => gold, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    portfolio.gold_transactions.quantity.should eq 10
    portfolio.gold_transactions.average_cost_price.should eq 3
  end

  describe "Net Worth" do

    subject {
      create_positions_of_all_securities
      portfolio
    }

    its(:stocks_value) { should eq 50 }
    its(:mutual_funds_value) { should eq 50 }
    its(:gold_value) { should eq 50 }
    its(:fixed_deposits_value) { should eq 106.58 }
    its(:real_estates_value) { should eq 600 }

    it "should calculate net worth of portfolio" do
      subject.net_worth.should eq 597.95
    end

    it "should calculate total asset value" do
      subject.total_assets_value.should eq 856.58
    end

    it "should calcualte total liabilities" do
      subject.total_liabilitites_value.should eq -258.63
    end

    def create_positions_of_all_securities
      stock = create :stock
      scrip = create :scrip, :last_traded_price => 5, :id => stock.symbol
      4.times { |n| create :stock_transaction, :stock => stock, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

      scheme = create :scheme_master
      navcp  = create :navcp, :nav_amount => "5", :security_code => scheme.securitycode
      4.times { |n| create :mutual_fund_transaction, :mutual_fund => create(:mutual_fund, :name => scheme.scheme_name), :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

      gold = create :gold, :name => "Gold", :current_price => 5
      4.times { |n| create :gold_transaction, :gold => gold, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

      loan =  create :loan, :name => "Foo Loan", :rate_of_interest => "10", :period => "1"
      loan_transaction =  create :loan_transaction, :loan => loan, :price => -1000, :date => 8.months.ago.to_date, :portfolio => portfolio

      fixed_deposit = create :fixed_deposit, :name => "Foo", :period => 5, :rate_of_interest => 10.0
      create :fixed_deposit_transaction, :fixed_deposit => fixed_deposit, :portfolio => portfolio, :price => 100, :date => 8.months.ago.to_date

      real_estate = create :real_estate, :name => "Test Property", :location => "Mordor", :current_price => 600
      create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 500, :date => Date.civil(2011, 12, 01)
    end
  end
end
