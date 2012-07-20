require 'spec_helper'

describe RealEstateTransaction do
  let(:real_estate_transaction) { create :real_estate_transaction }

  subject { real_estate_transaction }
  it { should validate_presence_of :price }
  it { should validate_presence_of :date }
  it { should validate_presence_of :action }
  it { should validate_presence_of :portfolio_id }
  it { should belong_to :portfolio }
  it { should belong_to :real_estate }
  it { should allow_value(1.day.ago).for(:date) }
  it { should allow_value(Date.today).for(:date) }
  it { should_not allow_value(1.day.from_now).for(:date) }
  it { should_not allow_value(-1).for(:price) }
  it { should ensure_length_of(:comments).is_at_most(75) }

  it "should get amount" do
    real_estate_transaction.action = "buy"
    real_estate_transaction.price = 20
    real_estate_transaction.amount.should be_a_indian_currency_of 20

    real_estate_transaction.action = "sell"
    real_estate_transaction.price = 10
    real_estate_transaction.amount.should be_a_indian_currency_of -10
  end

  it "should give percentage change of market value" do
    real_estate = create :real_estate, :name => "Test Property", :location => "Mordor", :current_price => 60000
    real_estate_transaction = create :real_estate_transaction, :real_estate => real_estate, :price => 50000, :date => Date.civil(2011, 12, 01), :action => "buy"
    real_estate_transaction.percentage_change.should eq 20
  end

  it "should have a profit or loss for sell transaction" do
    portfolio = create :portfolio
    real_estate = create :real_estate,:name => "Test Property", :location => "Mordor", :current_price => 100000
    create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 100000, :date => 8.months.ago.to_date
    transaction = create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 120000, :date => 1.months.ago.to_date, :action => "sell"

    transaction.profit_or_loss.should be_a_indian_currency_of 20000

  end

  it "should validate sell date < buy date" do
    portfolio = create :portfolio
    real_estate = create :real_estate,:name => "Test Property", :location => "Mordor", :current_price => 100000
    create :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 100000, :date => 8.months.ago.to_date
    sell_transaction = build :real_estate_transaction, :real_estate => real_estate, :portfolio => portfolio, :price => 100000, :date => 9.months.ago.to_date, :action => "sell"
    sell_transaction.valid?.should be_false
  end


end
