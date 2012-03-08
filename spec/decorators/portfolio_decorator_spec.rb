require 'spec_helper'

describe PortfolioDecorator do
  before { ApplicationController.new.set_current_view_context }
  let (:portfolio) { create :portfolio }
  subject {
    create_securities
    PortfolioDecorator.decorate(portfolio)
  }

  its(:stocks_percentage) { should eq 5.84 }
  its(:mutual_funds_percentage) { should eq 5.84 }
  its(:gold_percentage) { should eq 5.84 }
  its(:fixed_deposits_percentage) { should eq 12.44 }
  its(:real_estates_percentage) { should eq 70.05 }

  def create_securities
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
