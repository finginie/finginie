require 'spec_helper'

describe "FixedDepositPosition" do
  let(:portfolio) { create :portfolio }
  let(:fixed_deposit) { create :fixed_deposit, :name => "Foo", :period => 5, :rate_of_interest => 10.0 }

  subject {
    create :fixed_deposit_transaction, :fixed_deposit => fixed_deposit, :portfolio => portfolio, :price => 100, :date => 8.months.ago.to_date
    portfolio.fixed_deposit_positions.first
  }

  its (:name) { should eq fixed_deposit.name }
  its (:invested_amount) { should be_a_indian_currency_of 100 }

  describe "Net Worth" do
    before(:all) { Timecop.freeze(Date.civil(2012, 03, 22)) }
    after(:all) { Timecop.return }
    its(:current_value) { should be_a_indian_currency_of 106.58 }
    its(:unrealised_profit) { should be_a_indian_currency_of 6.58 }
    its(:unrealised_profit_percentage) { should eq 6.58 }

    it "should calculate the profit or loss percentage" do
      subject
      fixed_deposit.update_attributes(:rate_of_redemption => 8)
      create :fixed_deposit_transaction, :date => 1.months.ago.to_date, :price => 100, :fixed_deposit => fixed_deposit, :portfolio => portfolio, :action => "sell"
      subject.all # reload all the transactions
      subject.profit_or_loss_percentage.should eq 4.64
    end
  end

   it "should calculate the profit or loss percentage for same date" do
    subject
    fixed_deposit.update_attributes(:rate_of_redemption => 8)
    create :fixed_deposit_transaction, :date => 8.months.ago.to_date, :price => 100, :fixed_deposit => fixed_deposit, :portfolio => portfolio, :action => "sell"
    subject.all # reload all the transactions
    subject.profit_or_loss_percentage.should eq 0.0
  end

   it "should calculate the profit or loss percentage with out rate of redemption" do
    subject
    create :fixed_deposit_transaction, :date => 8.months.ago.to_date, :price => 100, :fixed_deposit => fixed_deposit, :portfolio => portfolio, :action => "sell"
    subject.all # reload all the transactions
    subject.profit_or_loss_percentage.should eq 0.0
  end
end
