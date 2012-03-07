require 'spec_helper'

describe Loan do
  it { should validate_presence_of :period }
  it { should validate_presence_of :rate_of_interest }
  it { should have_many :loan_transactions }

  let(:loan) { create :loan, :period => 5, :rate_of_interest => 12.5 }
  describe "transaction" do
    let(:transaction) { create :transaction, :net_position => create(:net_position, :security => loan), :price => 300000, :date => Date.civil(2011, 8, 01) }
    subject { transaction }
    its(:current_value) {
      Timecop.freeze Date.civil(2011, 11, 11) do
        should eq -285276
      end
    }
  end

  it "should allow repay transaction for a borrowed transaction" do
    loan = create :loan, :period => 1, :rate_of_interest => 10, :name => "Test Loan"
    loan_transaction = create :loan_transaction, :loan => loan, :portfolio => create(:portfolio), :price => -100000, :date => 8.months.ago.to_date
    loan.repay(loan_transaction).should be_true
  end
end
