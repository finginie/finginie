require 'spec_helper'

describe Portfolio, :redis do
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

  it { should have_many :mutual_funds }
  it { should have_many :loans }
  it { should have_many :fixed_deposits }
  it { should have_many :real_estates }

  it "should have_many companies" do
    company = create :'data_provider/company'
    4.times { |n| create :stock_transaction, :company_code =>company.code, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }
    subject.companies.should include company
  end

  its(:net_worth) { should eq 0 }
  its(:total_assets_value) { should eq 0 }
  its(:total_liabilitites_value) { should eq 0 }

  it "should have many stock_positions" do
    company = create :'data_provider/company'
    4.times { |n| create :stock_transaction, :company_code => company.code, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }
    4.times { |n| create :stock_transaction, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    portfolio.stock_transactions.for(company).quantity.should eq 10
    portfolio.stock_transactions.for(company).average_cost_price.should eq 3
  end

  it "should have many mutual_fund_positions" do
    mutual_fund = create :mutual_fund
    4.times { |n| create :mutual_fund_transaction, :mutual_fund => mutual_fund, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    portfolio.mutual_fund_transactions.for(mutual_fund).quantity.should eq 10
    portfolio.mutual_fund_transactions.for(mutual_fund).average_cost_price.should eq 3
  end

  it "should have a gold position" do
    4.times { |n| create :gold_transaction, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    portfolio.gold_transactions.for(DataProvider::Gold).quantity.should eq 10
    portfolio.gold_transactions.for(DataProvider::Gold).average_cost_price.should eq 3
  end

  describe "Net Worth" do
    before(:all) { Timecop.freeze(Date.civil(2012, 03, 22)) }
    after(:all) { Timecop.return }

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
  end

  def create_positions_of_all_securities
    company = create :'data_provider/company', :industry_name => "FOO"
    scrip = create :'data_provider/nse_scrip', :last_traded_price => 5, :id => company.nse_code
    4.times { |n| create :stock_transaction, :company_code => company.code, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    scheme = create :'data_provider/scheme', :nav_amount => "5"
    4.times { |n| create :mutual_fund_transaction, :scheme => scheme.name, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    create :'data_provider/nse_scrip', :id => "GOLDBEES", :last_traded_price => 5
    4.times { |n| create :gold_transaction, :portfolio => portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }

    loan =  create :loan, :name => "Foo Loan", :rate_of_interest => "10", :period => "1"
    loan_transaction =  create :loan_transaction, :loan => loan, :price => 1000, :date => Date.civil(2011,07,22), :portfolio => portfolio, :action => "borrow"

    fixed_deposit = create :fixed_deposit, :name => "Foo", :period => 5, :rate_of_interest => 10.0
    create :fixed_deposit_transaction, :fixed_deposit => fixed_deposit, :portfolio => portfolio, :price => 100, :date => Date.civil(2011,07,22)

    real_estate = create :real_estate, :name => "Test Property", :location => "Mordor", :current_price => 600
    create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 500, :date => Date.civil(2011, 12, 01), :action => "buy"
  end
end
