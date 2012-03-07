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

  def add_mutual_fund_position(portfolio, amount1, amount2, quantity)
    position = create :net_position, :portfolio => portfolio,
                                     :security => create(:mutual_fund)
    create :transaction, :net_position => position, :quantity => quantity, :price => amount1
    create :transaction, :net_position => position, :quantity => quantity, :price => amount2
  end

  def add_mutual_fund_position_without_transaction(portfolio)
    position = create :net_position, :portfolio => portfolio,
                                     :security => create(:mutual_fund)
  end
end
