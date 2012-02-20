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

  it "should calculate the net worth of a portfolio" do
    add_stock_position(portfolio, 100, 227.5)
    add_stock_position(portfolio, 200, 821)
    add_stock_position(portfolio, 250, 34.6)

    add_fixed_income(portfolio, 5, 8.89,  10000, Date.civil(2007, 1, 31))
    add_fixed_income(portfolio, 5, 9.75, 500000, Date.civil(2008, 1, 18))

    add_loan_position(portfolio,  5, 12.50,  300000, Date.civil(2011, 8, 1))
    add_loan_position(portfolio, 10, 12.75, 1500000, Date.civil(2010, 1, 1))

    Timecop.freeze Date.civil(2011, 11, 11) do
      portfolio.net_worth.should eq -699944
    end
  end

  def add_stock_position(portfolio, quantity, price)
    stock_position = create :net_position, :portfolio => portfolio,
                                           :security => create(:stock)
    create :transaction, :net_position => stock_position, :quantity => quantity
    create :scrip, :id => stock_position.security.symbol, :last_traded_price => price
  end

  def add_fixed_income(portfolio, period, interest_rate, amount, date)
    position = create :net_position, :portfolio => portfolio,
                                     :security => create(:fixed_income, :period => period, :rate_of_interest => interest_rate)
    create :transaction, :net_position => position, :date => date, :price => amount
  end

  def add_loan_position(portfolio, period, interest_rate, amount, date)
    position = create :net_position, :portfolio => portfolio,
                                     :security => create(:loan, :period => period, :rate_of_interest => interest_rate)
    create :transaction, :net_position => position, :date => date, :price => amount
  end
end
