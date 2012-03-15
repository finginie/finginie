require 'spec_helper'

describe RealEstateTransaction do
  let(:real_estate_transaction) { create :real_estate_transaction }
  it { should validate_presence_of :price }
  it { should validate_presence_of :date }
  it { should validate_presence_of :portfolio_id }
  it { should belong_to :portfolio }
  it { should belong_to :real_estate }
  it { should allow_value(1.day.ago).for(:date) }
  it { should allow_value(Date.today).for(:date) }
  it { should_not allow_value(1.day.from_now).for(:date) }

  it "should get action and amount" do
    real_estate_transaction.price = 20
    real_estate_transaction.action.should eq :buy
    real_estate_transaction.amount.should eq 20

    real_estate_transaction.price = -20
    real_estate_transaction.action.should eq :sell
    real_estate_transaction.amount.should eq 20
  end

  it "should set action and amount" do
    real_estate_transaction.action = :buy
    real_estate_transaction.amount = 20
    real_estate_transaction.price.should eq 20

    real_estate_transaction.action = :sell
    real_estate_transaction.amount = 10
    real_estate_transaction.price.should eq -10
  end

  it "should give percentage change of market value" do
    real_estate = create :real_estate, :name => "Test Property", :location => "Mordor", :current_price => 60000 
    real_estate_transaction = create :real_estate_transaction, :real_estate => real_estate, :price => 50000, :date => Date.civil(2011, 12, 01)
    real_estate_transaction.percentage_change.should eq 20
  end

  it "should have a profit or loss for sell transaction" do
    portfolio = create :portfolio
    real_estate = create :real_estate,:name => "Test Property", :location => "Mordor", :current_price => 100000
    create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 100000, :date => 8.months.ago.to_date
    transaction = create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => -120000, :date => 1.months.ago.to_date

    transaction.profit_or_loss.should eq 20000

  end

end