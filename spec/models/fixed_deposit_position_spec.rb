require 'spec_helper'

describe "FixedDepositPosition" do
  let(:portfolio) { create :portfolio }
  let(:fixed_deposit) { create :fixed_deposit, :name => "Foo", :period => 5, :rate_of_interest => 10.0 }

  subject {
    create :fixed_deposit_transaction, :fixed_deposit => fixed_deposit, :portfolio => portfolio, :price => 100, :date => 8.months.ago.to_date
    portfolio.fixed_deposit_positions.first
  }

  its (:name) { should eq fixed_deposit.name }
  its (:invested_amount) { should eq 100 }

  its (:current_value) {
      should eq 106.58
  }

  its (:unrealised_profit) { should eq 6.58 }
end
