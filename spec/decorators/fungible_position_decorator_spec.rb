require 'spec_helper'

describe FungiblePositionDecorator do
  before(:each) {
    @portfolio = create :portfolio
    @company = create :'data_provider/company', :industry_name => "FOO"
    4.times { |n| create :stock_transaction, :company_code => @company.code, :portfolio => @portfolio, :quantity => n+1, :price => n+1, :date => (n +1).days.ago  }
  }

  subject {
    FungiblePositionDecorator.custom_decorate(@portfolio.stock_positions.first)
  }

  its(:current_price)     { should eq "-" }
  its(:unrealised_profit) { should eq "-" }
  its(:action_params) { should eq({action: :sell, quantity: 10, company_code: @company.code }) }

end
