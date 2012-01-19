require 'spec_helper'

describe NetPosition do
  let (:stock) { create :stock }
  let (:net_position) { create :net_position, :security => stock }
  subject { net_position }
  before :each do
    create :scrip, :id => stock.symbol, :last_traded_price => 20
  end

  it { should have_many :transactions }
  it { should belong_to :portfolio }
  it { should belong_to :security }
  it { should validate_presence_of :security_id }
  it { should validate_presence_of :portfolio_id }

  def verify_for_values(property, *values)
    net_position.transactions.create build(:transaction, :quantity => 100, :price => 10).attributes
    net_position.send(property).should eq values[0]
    net_position.transactions.create build(:transaction, :quantity => 100, :price => 12).attributes
    net_position.send(property).should eq values[1]
    net_position.transactions.create build(:transaction, :quantity => -150, :price => 13).attributes
    net_position.send(property).should eq values[2]
    net_position.transactions.create build(:transaction, :quantity => -50, :price => 14).attributes
    net_position.send(property).should eq values[3]
  end

  it "should calculate net quantity" do
    verify_for_values :quantity, 100, 200, 50, 0
  end

  it "should calculate buy quantity" do
    verify_for_values :buy_quantity, 100, 200, 200, 200
  end

  it "should calculate sale quantity" do
    verify_for_values :sale_quantity, 0, 0, 150, 200
  end

  it "should calculate total cost" do
    verify_for_values :total_cost, 1000, 2200, 2200, 2200
  end

  it "should calculate total sale" do
    verify_for_values :total_sale, 0, 0, 1950, 2650
  end

  it "should calculate average cost" do
    verify_for_values :average_cost, 10, 11, 11, 11
  end

  it "should calculate current value" do
    verify_for_values :current_value, 2000, 4000, 1000, 0
  end

  it "should calculate unrealised profits" do
    verify_for_values :unrealised_profit, 1000, 1800, 450, 0
  end

  it "should calculate profits" do
    verify_for_values :profit, 0, 0, 300, 450
    pending do
      net_position.transactions[0].profit.should eq 0
      net_position.transactions[1].profit.should eq 0
      net_position.transactions[2].profit.should eq 300
      net_position.transactions[3].profit.should eq 150
    end
  end

  it "should build the right security class based on the type" do
    NetPosition.new(:security_attributes => { :type => 'Loan' }).security.type.should eq 'Loan'
  end
end
