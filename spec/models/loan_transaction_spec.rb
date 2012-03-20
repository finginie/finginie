require 'spec_helper'

describe LoanTransaction do
  let(:loan_transaction) { create :loan_transaction }
  it { should belong_to :portfolio }
  it { should belong_to :loan }
  it { should validate_presence_of :portfolio_id }
  it { should validate_presence_of :price }
  it { should validate_presence_of :date }
  it { should validate_numericality_of :price }
  it { should allow_value(1.day.ago).for(:date) }
  it { should allow_value(Date.today).for(:date) }
  it { should_not allow_value(1.day.from_now).for(:date) }
  it { should_not allow_value(-1).for(:price) }

  it "should get amount" do
    loan_transaction.action = "repay"
    loan_transaction.price = 20
    loan_transaction.amount.should eq 20

    loan_transaction.action = "borrow"
    loan_transaction.price = 10
    loan_transaction.amount.should eq -10
  end

  it "should not allow repay transaction if there is no borrow transaction for that loan" do
    loan_transaction = create :loan_transaction
    loan_transaction.action = "repay"
    loan_transaction.price = 20
    loan_transaction.valid?.should be_false
  end

end
