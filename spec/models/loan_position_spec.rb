require 'spec_helper'

describe "LoanPosition" do
  let(:portfolio) { create :portfolio }
  let(:loan) { create :loan, :name => "Foo Loan", :rate_of_interest => "10", :period => "1"}
  let(:loan_transaction) { create :loan_transaction, :loan => loan, :price => -100000, :date => 8.months.ago.to_date, :portfolio => portfolio }

  subject {
    loan_transaction.save
    portfolio.loan_positions.first
  }

  its(:name) { should eq "Foo Loan" }
  its(:rate_of_interest) { should eq 10 }
  its(:period) { should eq 1 }
  its(:date) { should eq 8.months.ago.to_date }

  it "should calculate present current value" do
    subject.outstanding_amount.should eq -25937.39
  end
end
