require 'spec_helper'

describe Loan do
  it { should validate_presence_of :period }
  it { should validate_presence_of :rate_of_interest }
  it { should validate_numericality_of :period }
  it { should validate_numericality_of :rate_of_interest }
  it { should_not allow_value(-1).for(:period) }
  it { should allow_value(1).for(:rate_of_interest) }
  it { should allow_value(12.75).for(:rate_of_interest) }
  it { should_not allow_value(12751).for(:rate_of_interest) }
  it { should_not allow_value(-1).for(:rate_of_interest) }
  it { should have_many :loan_transactions }

  it "should allow repay transaction for a borrowed transaction" do
    loan = create :loan, :period => 1, :rate_of_interest => 10, :name => "Test Loan"
    loan_transaction = create :loan_transaction, :loan => loan, :portfolio => create(:portfolio), :price => 100000, :date => 8.months.ago.to_date
    loan.repay(loan_transaction).should be_true
  end

  it "should delete associate child records" do
    loan = create :loan
    create :loan_transaction, :loan => loan
    lambda {
        loan.destroy
    }.should change(LoanTransaction, :count).by(-1)
  end
end
