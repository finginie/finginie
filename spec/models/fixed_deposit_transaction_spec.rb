require 'spec_helper'

describe FixedDepositTransaction do
  let(:fixed_deposit_transaction) { create :fixed_deposit_transaction }
  subject { fixed_deposit_transaction }

  it { should validate_presence_of :price }
  it { should validate_presence_of :date }
  it { should validate_presence_of :portfolio_id }
  it { should validate_numericality_of :price }
  it { should belong_to :portfolio }
  it { should allow_value(1.day.ago).for(:date) }
  it { should allow_value(Date.today).for(:date) }
  it { should_not allow_value(1.day.from_now).for(:date) }
  it { should_not allow_value(-1).for(:price) }
  it { should ensure_length_of(:comments).is_at_most(75) }

  it "should get amount" do
    fixed_deposit_transaction.action = "buy"
    fixed_deposit_transaction.price = 20
    fixed_deposit_transaction.amount.should be_a_indian_currency_of 20

    fixed_deposit_transaction.action = "sell"
    fixed_deposit_transaction.price = 10
    fixed_deposit_transaction.amount.should be_a_indian_currency_of -10
  end

  it "should give correct porfit or loss for redeemed deposit" do
    Timecop.freeze(Date.civil(2012,03,22)) do
      portfolio = create :portfolio
      fixed_deposit_1 = create :fixed_deposit, :period => 1, :rate_of_interest => 10, :name => "Test Fixed Deposit"
      fixed_deposit_transaction_1 = create :fixed_deposit_transaction, :date => 8.months.ago.to_date, :price => 100000, :fixed_deposit => fixed_deposit_1, :portfolio => portfolio

      fixed_deposit_1.update_attributes(:rate_of_redemption => 8)
      fixed_deposit_transaction_2 = create :fixed_deposit_transaction, :date => 1.months.ago.to_date, :price => 100000, :fixed_deposit => fixed_deposit_1, :portfolio => portfolio, :action => "sell"
      fixed_deposit_transaction_2.profit_or_loss.should be_a_indian_currency_of 4637.65
    end
  end

  it "should validate redemption date" do
    portfolio = create :portfolio
    fixed_deposit_1 = create :fixed_deposit, :period => 1, :rate_of_interest => 10, :name => "Test Fixed Deposit"
    fixed_deposit_transaction_1 = create :fixed_deposit_transaction, :date => 8.months.ago.to_date, :price => 100000, :fixed_deposit => fixed_deposit_1, :portfolio => portfolio
    fixed_deposit_transaction_2 = build :fixed_deposit_transaction, :date => 9.months.ago.to_date, :price => 100000, :fixed_deposit => fixed_deposit_1, :portfolio => portfolio, :action => "sell"
    fixed_deposit_transaction_2.valid?.should be_false
  end
end
